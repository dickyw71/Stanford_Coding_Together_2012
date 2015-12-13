//
//  TopPlaces2Tests.m
//  TopPlaces2Tests
//
//  Created by Richard Wheatley on 28/07/2012.
//  Copyright (c) 2012 Richard Wheatley. All rights reserved.
//

#import "TopPlaces2Tests.h"
#import "FlickrFetcher.h"

@interface TopPlaces2Tests()
@property (nonatomic, strong) FlickrFetcher *flickrFetcher;
@end

@implementation TopPlaces2Tests
@synthesize flickrFetcher = _flickrFetcher;

- (void)setUp
{
    [super setUp];
    _flickrFetcher = [[FlickrFetcher alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testCheckingPhotoID
{
    //  get an array of photos
    //  check for photos with the same PhotoID
    
    
}

- (void)testPhotosInPlace
{
    NSArray *topPlaces = [[self.flickrFetcher class] topPlaces];
    NSArray *photosInPlace = [[self.flickrFetcher class] photosInPlace:[topPlaces objectAtIndex:0] maxResults:10];
    NSLog (@"%@", [photosInPlace description]);
}

- (void)testPhotoInPlace
{
    NSArray *topPlaces = [[self.flickrFetcher class] topPlaces];
    NSArray *photosInPlace = [[self.flickrFetcher class] photosInPlace:[topPlaces objectAtIndex:0] maxResults:10];
    NSLog (@"%@", [photosInPlace description]);
}

@end
