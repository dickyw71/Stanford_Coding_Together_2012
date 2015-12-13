//
//  FaceView.h
//  Happiness
//
//  Created by CS193p Instructor on 4/19/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//
// A UIView that shows a face whose smile is moveable.

#import <UIKit/UIKit.h>

@class FaceView;

@protocol FaceViewDataSource
// returns smileyness between -1.0 (sad) and 1.0 (happy)
- (double)smileForFaceView:(FaceView *)requestor;
@end

@interface FaceView : UIView

// how big the face is
// 1.0 means it's diameter will be the smaller of the view's width or height
// 2.0 is twice as large as that
// 0.5 is half the size of that
@property (nonatomic) CGFloat scale;

// will resize the face based on pinching
- (void)pinch:(UIPinchGestureRecognizer *)gesture;

// object to delegate the provision of this view's "data" (smileyness) to
@property (nonatomic, weak) id <FaceViewDataSource> dataSource;

@end
