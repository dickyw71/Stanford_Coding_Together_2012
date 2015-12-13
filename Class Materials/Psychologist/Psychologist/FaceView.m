//
//  FaceView.m
//  Happiness
//
//  Created by CS193p Instructor on 4/19/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import "FaceView.h"

@implementation FaceView

@synthesize scale = _scale;
@synthesize dataSource = _dataSource;

#define DEFAULT_SIZE 0.90

// return the DEFAULT_SIZE if _scale is not set (i.e. is zero)

- (CGFloat)scale
{
    if (!_scale) {
        return DEFAULT_SIZE;
    } else {
        return _scale;
    }
}

// don't allow negative scales
// we need a redraw when scale changes

- (void)setScale:(CGFloat)scale
{
    if (scale >= 0) {
        _scale = scale;
    }
    [self setNeedsDisplay];
}

// handler for a pinch gesture
// modifies self.scale by the amount the pinch changes each update

- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        self.scale *= gesture.scale;
        gesture.scale = 1;
    }
}

// subroutine to draw a circle

- (void)drawCircleAtPoint:(CGPoint)p withRadius:(CGFloat)radius inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);  // save the context state at the start ...
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0, 2*M_PI, YES);
    CGContextStrokePath(context);
    UIGraphicsPopContext();         // ... then restore it so that callers aren't affected
}

// our primary drawing routine

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // find the center point in our own coordinate system (bounded by self.bounds)
    CGPoint midPoint;
    midPoint.x = self.bounds.origin.x + self.bounds.size.width/2;
    midPoint.y = self.bounds.origin.y + self.bounds.size.height/2;
    
    // make our size relative to the smaller of our width or height
    CGFloat size = self.bounds.size.width/2;
    if (self.bounds.size.height < self.bounds.size.width) size = self.bounds.size.height/2;
    size *= self.scale;
    
    // set drawing attributes in the context
    CGContextSetLineWidth(context, 5.0);
    [[UIColor blueColor] setStroke];
    
    // draw the head using a subroutine
    [self drawCircleAtPoint:midPoint withRadius:size inContext:context];
    
    // draw the eyes (using the same subroutine)
#define EYE_H 0.35
#define EYE_V 0.35
#define EYE_RADIUS 0.10
    
    CGPoint eyePoint;
    eyePoint.x = midPoint.x - size * EYE_H;
    eyePoint.y = midPoint.y - size * EYE_V;
    [self drawCircleAtPoint:eyePoint withRadius:size*EYE_RADIUS inContext:context];
    eyePoint.x += size * EYE_H * 2;
    [self drawCircleAtPoint:eyePoint withRadius:size*EYE_RADIUS inContext:context];

    // draw the mouth
#define MOUTH_H 0.45
#define MOUTH_V 0.40
#define MOUTH_SMILE 0.25
    
    CGPoint mouthStart;
    mouthStart.x = midPoint.x - MOUTH_H * size;
    mouthStart.y = midPoint.y + MOUTH_V * size;
    CGPoint mouthEnd = mouthStart;
    mouthEnd.x += MOUTH_H * size * 2;
    CGPoint mouthCP1 = mouthStart;
    mouthCP1.x += MOUTH_H * size * 2/3;
    CGPoint mouthCP2 = mouthEnd;
    mouthCP2.x -= MOUTH_H * size * 2/3;
    
    // get the amount of smile from our dataSource (if any)
    // we have to delegate this because how much smile is our view's "data"
    //  and we can't "own that data" by making the smile a property on ourselves, for example
    float smile = [self.dataSource smileForFaceView:self];
    if (smile > 1.0) smile = 1.0;
    if (smile < -1.0) smile = -1.0;
    
    // adjust the mouth control points based on the amount of smile
    CGFloat smileOffset = MOUTH_SMILE * size * smile;
    mouthCP1.y += smileOffset;
    mouthCP2.y += smileOffset;
    
    // use a bezier curve drawing function in Core Graphics to draw the mouth
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, mouthStart.x, mouthStart.y);
    CGContextAddCurveToPoint(context, mouthCP1.x, mouthCP1.y, mouthCP2.x, mouthCP2.y, mouthEnd.x, mouthEnd.y);
    CGContextStrokePath(context);
}

/* 
 // Initialization
 //
 // we don't actually need any initialization in this demo
 //  (since we can set the contentMode in Xcode's Inspector)
 // this code is just here for reference
 // initialization usually happens lazily in property getters anyway
 // but, if you feel you must do it on creation, then initialization should happen in both
 //  initWithFrame: (in case someone uses alloc/initWithFrame: to create a FaceView) &
 //  awakeFromNib (in case this FaceView came out of a storyboard)

- (void)setup
{
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
*/

@end
