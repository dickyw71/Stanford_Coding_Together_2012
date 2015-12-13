//
//  FlickrPhotoAnnotation.h
//  Shutterbug
//
//  Created by CS193p Instructor on 5/8/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface FlickrPhotoAnnotation : NSObject <MKAnnotation>
@property (nonatomic, strong) NSDictionary *photo; // Flickr photo info
@end
