//
//  MapViewController.m
//  Shutterbug
//
//  Created by CS193p Instructor on 5/8/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
@end

@implementation MapViewController

@synthesize mapView;

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
