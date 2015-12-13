//
//  RecentlyViewedPhotosTableViewController.m
//  TopPlaces2
//
//  Created by Richard Wheatley on 28/07/2012.
//  Copyright (c) 2012 Richard Wheatley. All rights reserved.
//

#import "RecentlyViewedPhotosTableViewController.h"
#import "FlickrFetcher.h"
#import "ImageViewController.h"

@interface RecentlyViewedPhotosTableViewController ()
@property (nonatomic, strong) NSArray *photos;   
@end

@implementation RecentlyViewedPhotosTableViewController
@synthesize photos = _photos;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSArray *)photos
{
    if(!_photos) _photos = [[NSUserDefaults standardUserDefaults] objectForKey:@"TopPlaces.RecentPhotos"];
    return _photos;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{    
    if ([segue.identifier isEqualToString:@"Show Recent Photo"]) {
        [segue.destinationViewController setPhoto:[self.photos objectAtIndex:[self.tableView indexPathForSelectedRow].row]];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
//    self.photos = [[NSUserDefaults standardUserDefaults] objectForKey:@"TopPlaces.RecentPhotos"];
//    [self.tableView reloadData];
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
    return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Recently Viewed Photo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *photoTitle = [[NSDictionary dictionaryWithDictionary:[self.photos objectAtIndex:indexPath.row]] valueForKey:FLICKR_PHOTO_TITLE];
    NSString *photoDescription = [[NSDictionary dictionaryWithDictionary:[self.photos objectAtIndex:indexPath.row]] valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
    
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
