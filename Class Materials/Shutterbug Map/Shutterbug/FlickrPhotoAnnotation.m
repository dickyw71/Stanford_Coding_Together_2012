//
//  FlickrPhotoAnnotation.m
//  Shutterbug
//
//  Created by CS193p Instructor on 5/8/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import "FlickrPhotoAnnotation.h"
#import "FlickrFetcher.h"

@implementation FlickrPhotoAnnotation

@synthesize photo = _photo;

- (NSString *)title
{
    return [self.photo objectForKey:FLICKR_PHOTO_TITLE];
}

- (NSString *)subtitle
{
    return [self.photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
}

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [[self.photo objectForKey:FLICKR_LATITUDE] doubleValue];
    coordinate.longitude = [[self.photo objectForKey:FLICKR_LONGITUDE] doubleValue];
    return coordinate;
}

@end
