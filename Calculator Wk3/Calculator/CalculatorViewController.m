//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Richard Wheatley on 28/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"
#import "CalcGraphViewController.h"


@interface CalculatorViewController() 
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic, strong) NSDictionary *varaibleValues;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize expression = _expression;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize varaibleValues = _varaibleValues;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (NSDictionary *)varaibleValues
{
    return _varaibleValues;
}

- (void)setVaraibleValues:(NSDictionary *)varaibleValues
{
    _varaibleValues = nil;
    _varaibleValues = [varaibleValues copy];
}

- (IBAction)graphPressed 
{
    id detail = [[self.splitViewController viewControllers] lastObject];
    [detail setProgram:self.brain.program];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{
    if ([segue.destinationViewController respondsToSelector:@selector(setProgram:)]) {
        if ([segue.identifier isEqualToString:@"ShowGraph"]) {
            [segue.destinationViewController setProgram:self.brain.program];
        }
     }
}

- (IBAction)digitPressed:(UIButton *)sender {
    
    NSString *digit = sender.currentTitle;
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    }
    else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    
}

#define X_VAR_VALUE 6.0
//  pushes a variable into the brain
//  don't update the display or the expression as that will be refactored
//  once the desriptionOfProgram: method is implemented in the brain
- (IBAction)variablePressed:(UIButton *)sender 
{
    [self.brain pushVariableOperand:sender.currentTitle];
    self.expression.text = [[self.brain class] descriptionOfProgram:self.brain.program];
    
    self.varaibleValues = [NSDictionary dictionaryWithObject:[NSNumber numberWithDouble:X_VAR_VALUE] forKey:sender.currentTitle];
}

- (IBAction)enterPressed 
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.expression.text = [[self.brain class] descriptionOfProgram:self.brain.program];
}

- (IBAction)backspacePressed 
{
    if (self.userIsInTheMiddleOfEnteringANumber)
    {
        self.display.text = [self.display.text substringToIndex:[self.display.text length]-1];
       
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
        }
    } 
    else {
        self.display.text = @"0.";
        self.userIsInTheMiddleOfEnteringANumber = YES;
        
    }
}

- (IBAction)clearPressed 
{
    //  clear the display
    self.display.text = @"0";
    self.userIsInTheMiddleOfEnteringANumber = NO;
        
    //  clear the brain!
    [self.brain clear];
    
    //  clear the expression
    self.expression.text = [[CalculatorBrain class] descriptionOfProgram:self.brain.program];
}


- (IBAction)operationPressed:(UIButton *)sender 
{
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        // enterPressed without adding 'Enter' to expression text
        [self.brain pushOperand:[self.display.text doubleValue]];
        self.userIsInTheMiddleOfEnteringANumber = NO;
    }   
    
    [self.brain performOperation:sender.currentTitle];    
    self.display.text = [NSString stringWithFormat:@"%g", [[self.brain class] runProgram:self.brain.program usingVariableValues:self.varaibleValues]];
    self.expression.text = [[self.brain class] descriptionOfProgram:self.brain.program];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)viewDidUnload {
    [self setExpression:nil];
    [super viewDidUnload];
}
@end
