//
//  TopPlacesViewController.m
//  TopPlaces2
//
//  Created by Richard Wheatley on 28/07/2012.
//  Copyright (c) 2012 Richard Wheatley. All rights reserved.
//

#import "TopPlacesViewController.h"

@interface TopPlacesViewController ()

@end

@implementation TopPlacesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
