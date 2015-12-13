//
//  HappinessViewController.h
//  Happiness
//
//  Created by CS193p Instructor on 4/19/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HappinessViewController : UIViewController

// this MVC's Model
// is public, but we still get to manage it via setter/getter
@property (nonatomic) int happiness;

@end
