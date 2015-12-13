//
//  RecentsViewController.m
//  Top Places
//
//  Created by Richard Wheatley on 27/07/2012.
//  Copyright (c) 2012 Richard Wheatley. All rights reserved.
//

#import "RecentsViewController.h"

@interface RecentsViewController ()

@end

@implementation RecentsViewController

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
