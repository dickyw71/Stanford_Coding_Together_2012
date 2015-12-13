//
//  TopPlacesTableViewController.m
//  TopPlaces2
//
//  Created by Richard Wheatley on 28/07/2012.
//  Copyright (c) 2012 Richard Wheatley. All rights reserved.
//

#import "TopPlacesTableViewController.h"
#import "FlickrFetcher.h"
#import "RecentPhotosInPlaceTableViewController.h"

@interface TopPlacesTableViewController ()
@property (nonatomic, strong) NSArray *topPlaces;   //  array of NSDictionays which contains information about each place
@property (nonatomic, strong) NSDictionary *selectedPlace;
@end

@implementation TopPlacesTableViewController
@synthesize topPlaces = _topPlaces;
@synthesize selectedPlace = _selectedPlace;

- (NSArray *)topPlaces
{
    if (!_topPlaces) {
        NSArray *tempArray = [[FlickrFetcher class] topPlaces];
        _topPlaces = [tempArray sortedArrayUsingComparator:^(id obj1, id obj2) {
            return [[obj1 valueForKey:FLICKR_PLACE_NAME] compare:[obj2 valueForKey:FLICKR_PLACE_NAME] options: NSCaseInsensitiveSearch | NSLiteralSearch];                 
        }];
        
    }
    return _topPlaces;
}

//  Segue to the recents photos for the selected place
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Recent Photos In Place"]) {
        [segue.destinationViewController setPlace:[self.topPlaces objectAtIndex:[self.tableView indexPathForSelectedRow].row]];
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

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView flashScrollIndicators];
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
    return [self.topPlaces count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Top Place Name";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    NSString *place = [[NSDictionary dictionaryWithDictionary:[self.topPlaces objectAtIndex:indexPath.row]] valueForKey:FLICKR_PLACE_NAME];
    NSArray *placeParts = [place componentsSeparatedByString:@","];
    NSString *placeTitle = [placeParts objectAtIndex:0];
    cell.textLabel.text = placeTitle;
    cell.detailTextLabel.text = [place stringByReplacingOccurrencesOfString:placeTitle withString:@""];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    self.selectedPlace = [self.topPlaces objectAtIndex:indexPath.row];    
}

@end
