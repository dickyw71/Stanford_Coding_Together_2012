//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Richard Wheatley on 28/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"


@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize expression = _expression;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    
    NSString *digit = sender.currentTitle;
    if (self.userIsInTheMiddleOfEnteringANumber) 
    {
        self.display.text = [self.display.text stringByAppendingString:digit];
    }
    else
    {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    
    self.expression.text = [self.expression.text stringByAppendingString:digit];
}

- (IBAction)enterPressed 
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    
    self.expression.text = [self.expression.text stringByAppendingString:@" Enter "];

}

- (IBAction)backspacePressed 
{
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        self.display.text = [self.display.text substringToIndex:[self.display.text length]-1];
        self.expression.text = [self.expression.text substringToIndex:[self.expression.text length]-1];
        if ([self.display.text length] == 0) {
            self.display.text = @"0";
        }
    }
}

- (IBAction)decimalPointPressed 
{
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        NSRange range = [self.display.text rangeOfString:@"."];
        if (range.location == NSNotFound) 
        {
            self.display.text = [self.display.text stringByAppendingString:@"."];
            self.expression.text = [self.expression.text stringByAppendingString:@"."];
        }
    } 
    else {
        self.display.text = @"0.";
        self.userIsInTheMiddleOfEnteringANumber = YES;
        self.expression.text = [self.expression.text stringByAppendingString:@" 0."];
        
    }
}

- (IBAction)clearPressed 
{
    //  clear the display
    self.display.text = @"0";
    self.userIsInTheMiddleOfEnteringANumber = NO;
    
    //  clear the expression
    self.expression.text = @"";
    
    //  clear the brain!
    [self.brain clear];
    
}

- (IBAction)operationPressed:(UIButton *)sender 
{
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        // enterPressed without sending 'Enter' to expression
        [self.brain pushOperand:[self.display.text doubleValue]];
        self.userIsInTheMiddleOfEnteringANumber = NO;
    }   
    
    double result = [self.brain performOperation:sender.currentTitle];
    self.display.text = [NSString stringWithFormat:@"%g", result];    
  
    NSString *operationString = [NSString stringWithFormat:@" %@ ", sender.currentTitle];    
    self.expression.text = [self.expression.text stringByAppendingString:operationString];
    self.expression.text = [self.expression.text stringByAppendingString:@" ="];
 
 }

- (void)viewDidUnload {
    [self setExpression:nil];
    [super viewDidUnload];
}
@end
