//
//  ShutterbugTVC.m
//  Shutterbug
//
//  Created by CS193p Instructor on 5/3/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import "ShutterbugTVC.h"
#import "FlickrFetcher.h"
#import "ImageViewController.h"
#import "FlickrPhotoAnnotation.h"
#import "MapViewController.h"

@interface ShutterbugTVC ()
@property (nonatomic, strong) NSArray *photos; // Flickr photo NSDictionary
@end

@implementation ShutterbugTVC

@synthesize photos = _photos;

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self.tableView reloadData];
}

#pragma mark - Target/Action

- (IBAction)refresh:(id)sender
{
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem *spinnerButton = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    self.navigationItem.rightBarButtonItem = spinnerButton;
    [spinner startAnimating];

    dispatch_queue_t fetchQueue = dispatch_queue_create("flickr photo fetch queue", NULL);
    dispatch_async(fetchQueue, ^{
        NSArray *photos = [FlickrFetcher recentGeoreferencedPhotos];
        dispatch_async(dispatch_get_main_queue(), ^{
            [spinner stopAnimating];
            self.navigationItem.rightBarButtonItem = sender;
            self.photos = photos;
        });
    });
    dispatch_release(fetchQueue);
}

#pragma mark - Autorotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
        ImageViewController *ivc = (ImageViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSDictionary *photo = [self.photos objectAtIndex:indexPath.row];
        ivc.imageURL = [FlickrFetcher urlForPhoto:photo format:FlickrPhotoFormatLarge];
        ivc.title = [photo objectForKey:FLICKR_PHOTO_TITLE];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Flickr Photo Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    NSDictionary *photo = [self.photos objectAtIndex:indexPath.row];
    cell.textLabel.text = [photo objectForKey:FLICKR_PHOTO_TITLE];
    cell.detailTextLabel.text = [photo objectForKey:FLICKR_PHOTO_OWNER];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (MKMapView *)mapView
{
    id detail = [[self.splitViewController viewControllers] lastObject];
    if ([detail isKindOfClass:[MapViewController class]]) {
        return ((MapViewController *)detail).mapView;
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MKMapView *mapView = [self mapView];
    if (mapView) {
        NSDictionary *photo = [self.photos objectAtIndex:indexPath.row];
        FlickrPhotoAnnotation *fpa = [[FlickrPhotoAnnotation alloc] init];
        fpa.photo = photo;
        [mapView addAnnotation:fpa];
        [mapView setCenterCoordinate:fpa.coordinate animated:YES];
    }
}

#pragma mark - View Controller Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.photos) [self refresh:nil];
}
   
@end
