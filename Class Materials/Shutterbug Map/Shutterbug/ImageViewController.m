//
//  ImageViewController.m
//  Shutterbug
//
//  Created by CS193p Instructor on 5/3/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation ImageViewController

@synthesize imageView = _imageView;
@synthesize spinner = _spinner;
@synthesize imageURL = _imageURL;

- (void)loadImage
{
    [self.spinner startAnimating];
    dispatch_queue_t downloadQueue = dispatch_queue_create("flickr photo download", NULL);
    dispatch_async(downloadQueue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:self.imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.spinner stopAnimating];
            self.imageView.image = image;
        });
    });
    dispatch_release(downloadQueue);
}

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    if (self.imageView.window) [self loadImage];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadImage];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [self setSpinner:nil];
    [super viewDidUnload];
}

@end
