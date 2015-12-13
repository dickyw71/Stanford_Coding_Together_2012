//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Richard Wheatley on 28/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *expression;
@property (weak, nonatomic) IBOutlet UILabel *variableValues;


@end
