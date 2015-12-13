//
//  HappinessViewController.m
//  Happiness
//
//  Created by CS193p Instructor on 4/19/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import "HappinessViewController.h"
#import "FaceView.h"

@interface HappinessViewController () <FaceViewDataSource>
// outlet to the FaceView in our storyboard used to display our Model
@property (weak, nonatomic) IBOutlet FaceView *faceView;
@end

@implementation HappinessViewController

@synthesize faceView = _faceView;
@synthesize happiness = _happiness;

// any time the Model changes, update the View

- (void)setHappiness:(int)happiness
{
    _happiness = happiness;
    [self.faceView setNeedsDisplay];
}

// called when iOS sets our outlet to the FaceView
// add gesture recognizers to the FaceView
// set ourselves as the dataSource of the FaceView so we can provide "smileyness"

- (void)setFaceView:(FaceView *)faceView
{
    _faceView = faceView;
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)]];
    [self.faceView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleHappinessGesture:)]];
    self.faceView.dataSource = self;
}

// implementation of the FaceViewDelegate protocol

- (double)smileForFaceView:(FaceView *)requestor
{
    return (self.happiness - 50) / 50.0;
}

// handler for pan gesture (adjust Model)
// note that "self.happiness =" means call setHappiness: which will setNeedsDisplay on self.faceView

- (void)handleHappinessGesture:(UIPanGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        CGPoint translation = [gesture translationInView:self.faceView];
        self.happiness -= translation.y / 2;
        [gesture setTranslation:CGPointZero inView:self.faceView];
    }
}

// we allow rotation to any orientation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end
