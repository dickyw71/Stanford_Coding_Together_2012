//
//  ImageViewController.m
//  TopPlaces2
//
//  Created by Richard Wheatley on 29/07/2012.
//  Copyright (c) 2012 Richard Wheatley. All rights reserved.
//

#import "ImageViewController.h"
#import "FlickrFetcher.h"

@interface ImageViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) NSURL *urlForPhoto;
@end

@implementation ImageViewController
@synthesize scrollView = _scrollView;
@synthesize imageView = _imageView;
@synthesize photo = _photo;
@synthesize urlForPhoto = _urlForPhoto;

- (NSURL *)urlForPhoto
{
    if(!_urlForPhoto) _urlForPhoto = [[FlickrFetcher class] urlForPhoto:self.photo format:FlickrPhotoFormatLarge];
    return _urlForPhoto;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#define RECENT_PHOTOS @"TopPlaces.RecentPhotos"

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.scrollView.delegate = self;
    
    self.navigationItem.title = [self.photo valueForKey:FLICKR_PHOTO_TITLE];
    NSLog(@"Photo title: %@", [self.photo valueForKey:FLICKR_PHOTO_TITLE]);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *recentPhotos = [[defaults objectForKey:RECENT_PHOTOS] mutableCopy];
    if (!recentPhotos) recentPhotos = [NSMutableArray array];
    [recentPhotos addObject:self.photo];
    [defaults setObject:recentPhotos forKey:RECENT_PHOTOS];
    [defaults synchronize];

}

- (void)viewWillAppear:(BOOL)animated
{
    dispatch_queue_t downloadQueue = dispatch_queue_create("image downloader", NULL);
    dispatch_async(downloadQueue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:self.urlForPhoto];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imageData];
            self.imageView.image = image;
            self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
            self.scrollView.contentSize = image.size;

            self.scrollView.minimumZoomScale = 0.5;
            self.scrollView.maximumZoomScale = 2.0;

            [self.scrollView zoomToRect:self.imageView.frame animated:NO];
        });
    });
    dispatch_release(downloadQueue);
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)sender
{
    return self.imageView;
}

@end
