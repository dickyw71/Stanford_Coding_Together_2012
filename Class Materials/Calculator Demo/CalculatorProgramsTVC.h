//
//  CalculatorProgramsTVC.h
//  Calculator
//
//  Created by CS193p Instructor on 5/1/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

// MVCs with this controller can segue to any MVC that implements setCalculatorProgram:.
// To do so, simply set the segue's identifier to "setCalculatorProgram".

#import <UIKit/UIKit.h>

@class CalculatorProgramsTVC;

@protocol CalculatorProgramsTVCDelegate
- (void)calculatorProgramsTVC:(CalculatorProgramsTVC *)sender didChooseProgram:(id)program;
@end

@interface CalculatorProgramsTVC : UITableViewController

@property (nonatomic, weak) id <CalculatorProgramsTVCDelegate> delegate;

@end
