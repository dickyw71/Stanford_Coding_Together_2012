//
//  CalculatorBrain.h
//  Calculator
//
//  Created by CS193p Instructor.
//  Copyright (c) 2012 Stanford University.
//  All rights reserved.
//
//  Implements the engine of an RPN calculator.

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

// push operands ...
- (void)pushOperand:(double)operand;
// ... then perform operations on those operands
- (double)performOperation:(NSString *)op;

// returns an object of unspecified class which
// represents the sequence of operands and operations
// since last clear
@property (nonatomic, readonly) id program;

// a string representing (to an end user) the passed program
// (programs are obtained from the program @property of a CalculatorBrain instance)
+ (NSString *)descriptionOfProgram:(id)program;

// runs the program (obtained from the program @property of a CalculatorBrain instance)
// if the last thing done in the program was pushOperand:, this returns that operand
// if the last thing done in the program was performOperation:, this evaluates it (recursively)
+ (double)runProgram:(id)program;

@end
