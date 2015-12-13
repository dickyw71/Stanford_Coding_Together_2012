//
//  MapViewController.h
//  Shutterbug
//
//  Created by CS193p Instructor on 5/8/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end
