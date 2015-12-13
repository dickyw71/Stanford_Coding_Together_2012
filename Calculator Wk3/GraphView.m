//
//  GraphView.m
//  Calculator
//
//  Created by Richard Wheatley on 15/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphView.h"
#import "AxesDrawer.h"

@interface GraphView()
@property (nonatomic, strong) AxesDrawer *axesDrawer;
@end

@implementation GraphView

@synthesize scale = _scale;
@synthesize origin = _origin;
@synthesize dataSource = _dataSource;
@synthesize axesDrawer = _axesDrawer;

- (AxesDrawer *)axesDrawer
{
    if(!_axesDrawer) _axesDrawer = [[AxesDrawer alloc] init];

    return _axesDrawer;    
}

#define DEFAULT_SCALE 0.025

// return the DEFAULT_SIZE if _scale is not set (i.e. is zero)

- (CGFloat)scale
{
    if (!_scale) {
        _scale = DEFAULT_SCALE;
    } 
    
    return _scale;
}

- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    [self setNeedsDisplay];
}

//  return the DEFAULT_ORIGIN point if _origin is not set (i.e. is zero)

- (CGPoint)origin
{
    if (!_origin.x && !_origin.y) {
        // find the center point in our own coordinate system (bounded by self.bounds)
        _origin.x = self.bounds.origin.x + self.bounds.size.width/2;
        _origin.y = self.bounds.origin.y + self.bounds.size.height/2;
    }
    return _origin;
}

- (void)setOrigin:(CGPoint)origin
{
    _origin.x = origin.x;
    _origin.y = origin.y;
    [self setNeedsDisplay];
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        self.scale *= gesture.scale;
        gesture.scale = 1;
    }   

}

// handler for pan gesture (adjust Model)
// note that "self.origin =" means call setHappiness: which will setNeedsDisplay on self.graphView

- (void)pan:(UIPanGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        CGPoint translation = [gesture translationInView:self];
        CGPoint newOrigin;
        newOrigin.x = self.origin.x + translation.x;
        newOrigin.y = self.origin.y + translation.y;
        self.origin = newOrigin;
        [gesture setTranslation:CGPointZero inView:self];
    }
}

- (void)handleSingleTripleTap:(UITapGestureRecognizer *)gesture
{
    CGPoint tapPoint = [gesture locationInView:self];
    self.origin = tapPoint;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    // set drawing attributes in the context
    CGContextSetLineWidth(context, 2.0);
    [[UIColor blackColor] setStroke];
        
    [[self.axesDrawer class] drawAxesInRect:self.bounds originAtPoint:self.origin scale:1/(self.scale)];
    
    //  iterate horizontally for each pixel in x-axis
    CGFloat scaleFactor = [self contentScaleFactor];
    
    CGContextBeginPath(context);

    CGPoint graphPoint, viewPoint;
    
    //  convert x from view to graph coordinate
    graphPoint.x = (self.bounds.origin.x - self.origin.x) * self.scale;
    
    //  get value of y (in graph coords)
    graphPoint.y = [self.dataSource valueOfY:self forX:graphPoint.x]; 
    
    //  convert graph point to view point
    viewPoint.x = self.origin.x + (graphPoint.x / self.scale);
    viewPoint.y = self.origin.y + (graphPoint.y / self.scale);
    
    //  Move to starting point 
    CGContextMoveToPoint(context, viewPoint.x, viewPoint.y);
    
    for (CGFloat x=self.bounds.origin.x+1; x < self.bounds.size.width*scaleFactor; x += 1/scaleFactor) {
        
        //  convert x from view to graph coordinate
        graphPoint.x = (x - self.origin.x) * self.scale;
        //  get value of y (in graph coords)
        graphPoint.y = [self.dataSource valueOfY:self forX:graphPoint.x]; 

        //  convert graph point to view point
        viewPoint.x = self.origin.x + (graphPoint.x / self.scale);
        viewPoint.y = self.origin.y + (graphPoint.y / self.scale);

        CGContextAddLineToPoint(context, viewPoint.x, viewPoint.y);
    }
    CGContextStrokePath(context);
   
}


@end
