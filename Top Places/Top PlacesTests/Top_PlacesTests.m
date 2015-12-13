//
//  Top_PlacesTests.m
//  Top PlacesTests
//
//  Created by Richard Wheatley on 27/07/2012.
//  Copyright (c) 2012 Richard Wheatley. All rights reserved.
//

#import "Top_PlacesTests.h"
#import "FlickrFetcher.h"

@interface Top_PlacesTests()
@property (nonatomic, strong) FlickrFetcher *flickrFetcher;
@end

@implementation Top_PlacesTests
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

- (void)testTopPlacesQuery
{
    NSArray *topPlaces = [[self.flickrFetcher class] topPlaces];
    NSString *myString = [topPlaces description];
    NSLog (@"%@", myString);
}

- (void)testPhotoInPlace
{
    NSArray *topPlaces = [[self.flickrFetcher class] topPlaces];
    NSArray *photosInPlace = [[self.flickrFetcher class] photosInPlace:[topPlaces objectAtIndex:0] maxResults:10];
    NSLog (@"%@", [photosInPlace description]);
}

@end
