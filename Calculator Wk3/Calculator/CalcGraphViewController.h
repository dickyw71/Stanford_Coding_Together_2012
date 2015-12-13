//
//  CalcGraphViewController.h
//  Calculator
//
//  Created by Richard Wheatley on 15/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"

@interface CalcGraphViewController : UIViewController

//  The Calc Graph Views Model data
//  an x-y plot point
@property (nonatomic) CGPoint plotPoint;
@property (nonatomic, strong) id program;

@end
