//
//  RecentPhotosInPlaceTableViewController.m
//  TopPlaces2
//
//  Created by Richard Wheatley on 28/07/2012.
//  Copyright (c) 2012 Richard Wheatley. All rights reserved.
//

#import "RecentPhotosInPlaceTableViewController.h"
#import "FlickrFetcher.h"
#import "ImageViewController.h"

@interface RecentPhotosInPlaceTableViewController ()
@property (nonatomic, strong) NSArray *photosInPlace;
@end

@implementation RecentPhotosInPlaceTableViewController

@synthesize place = _place;
@synthesize photosInPlace = _photosInPlace;


- (NSArray *)photosInPlace
{
//    dispatch_queue_t photosInPlaceQueue = dispatch_queue_create("photosInPlace", NULL);
//    dispatch_async(photosInPlaceQueue, ^{
        if(!_photosInPlace) _photosInPlace = [[FlickrFetcher class] photosInPlace:self.place maxResults:50];
//    });
//    dispatch_release(photosInPlaceQueue);
    return _photosInPlace;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Photo Image"]) {
        [segue.destinationViewController setPhoto:[self.photosInPlace objectAtIndex:[self.tableView indexPathForSelectedRow].row]];
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return [self.photosInPlace count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Recent Photo For Place";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *photoTitle = [[NSDictionary dictionaryWithDictionary:[self.photosInPlace objectAtIndex:indexPath.row]] valueForKey:FLICKR_PHOTO_TITLE];
    NSString *photoDescription = [[NSDictionary dictionaryWithDictionary:[self.photosInPlace objectAtIndex:indexPath.row]] valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
    
    if (photoTitle.length > 0) {
        cell.textLabel.text = photoTitle;
        cell.detailTextLabel.text = photoDescription;
    } else if (photoDescription.length > 0) {
        cell.textLabel.text = photoDescription;
        cell.detailTextLabel.text = @"";        
    } else {
        cell.textLabel.text = @"Unknown";
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
