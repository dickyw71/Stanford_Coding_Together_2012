//
//  GraphView.h
//  Calculator
//
//  Created by Richard Wheatley on 15/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GraphView;

@protocol GraphViewDataSource
//  gets the y-axis value to plot for the specified x-axis value
- (double)valueOfY:(GraphView *)requestor forX:(double)value;
@end

@interface GraphView : UIView

// how big the graph is
// 1.0 means it's boundary will be the smaller of the view's width or height
// 2.0 is twice as large as that
// 0.5 is half the size of that
@property (nonatomic) CGFloat scale;

//  where is the graphs origin (defaults to mid-point of view)
@property (nonatomic) CGPoint origin;

// will resize the graph based on pinching
- (void)pinch:(UIPinchGestureRecognizer *)gesture;

// will move the entire graph including axes to follow touch around
- (void)pan:(UIPanGestureRecognizer *)gesture;

// object to delegate the provision of this view's "data" (y-axis value) to
@property (nonatomic, weak) id <GraphViewDataSource> dataSource;

@end
