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
@property (nonatomic, strong) NSMutableDictionary *testVariableValues;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize expression = _expression;
@synthesize variableValues = _variableValues;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize testVariableValues = _testVariableValues;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (NSMutableDictionary *)testVariableValues
{
    if (!_testVariableValues) _testVariableValues = [[NSMutableDictionary alloc] initWithCapacity:3];
    return _testVariableValues;
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

//  pushes a variable into the brain
//  don't update the display or the expression as that will be refactored
//  once the desriptionOfProgram: method is implemented in the brain
- (IBAction)variablePressed:(UIButton *)sender 
{
    [self.brain pushVariableOperand:sender.currentTitle];
    self.expression.text = [[self.brain class] descriptionOfProgram:self.brain.program];
}

- (IBAction)enterPressed 
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    
    //  get all the variables used in program
    //    NSSet *variablesInProgram = [[self.brain class] variablesUsedInProgram:self.brain.program];
    //  setup the variableValues
    //[self.testVariableValues  
    
    double result = [[self.brain class] runProgram:self.testVariableValues];
    self.display.text = [NSString stringWithFormat:@"%g", result]; 
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
    self.expression.text = [[self.brain class] descriptionOfProgram:self.brain.program];
}


- (IBAction)operationPressed:(UIButton *)sender 
{
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        // enterPressed without adding 'Enter' to expression text
        [self.brain pushOperand:[self.display.text doubleValue]];
        self.userIsInTheMiddleOfEnteringANumber = NO;
    }   
    
    double result = [self.brain performOperation:sender.currentTitle];
    self.display.text = [NSString stringWithFormat:@"%g", result];    
  
    self.expression.text = [[self.brain class] descriptionOfProgram:self.brain.program];
}

- (void)setVariableValues
{
    NSSet *variablesInProgram = [[self.brain class] variablesUsedInProgram:self.brain.program];
    
    self.variableValues.text = @"";
    for (NSString *s in variablesInProgram) {
        self.variableValues.text = [NSString stringWithFormat:@"%@ = %d ", s, [self.testVariableValues valueForKey:s]];    
    }
}

- (IBAction)test1Pressed 
{
    self.testVariableValues = nil;
    
    self.variableValues.text = @"";
}

- (IBAction)test2Pressed 
{
    NSNumber *x     = [NSNumber numberWithInt:3];
    NSNumber *y     = [NSNumber numberWithFloat:6.2];
    NSNumber *foo   = [NSNumber numberWithDouble:4.3];
    
    [self.testVariableValues setValue:x forKey:@"x"];
    [self.testVariableValues setValue:y forKey:@"y"];
    [self.testVariableValues setValue:foo forKey:@"foo"];
    
    
     
}

- (IBAction)test3Pressed 
{
    NSNumber *x     = [NSNumber numberWithInt:10];
    NSNumber *y     = [NSNumber numberWithFloat:-1.0];
    NSNumber *foo   = [NSNumber numberWithDouble:25.0];
    
    [self.testVariableValues setValue:x forKey:@"x"];
    [self.testVariableValues setValue:y forKey:@"y"];
    [self.testVariableValues setValue:foo forKey:@"foo"];    
}


- (void)viewDidUnload {
    [self setExpression:nil];
    [self setVariableValues:nil];
    [super viewDidUnload];
}
@end
