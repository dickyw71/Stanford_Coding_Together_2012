//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Richard Wheatley on 28/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (NSMutableArray *)programStack
{
    if (_programStack == nil) _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

- (id)program
{
    return [self.programStack copy];
}

- (void)clear
{
    [self.programStack removeAllObjects];
}

- (void) pushOperand:(double)operand
{
    //  
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

//  Private helper methods
//  to decide the kind of operation 
+ (BOOL)isOperation:(NSString *)operation
{
    NSSet *operations = [NSSet setWithObjects:
                         @"+", 
                         @"-",
                         @"/",
                         @"*",
                         @"sqrt",
                         @"sin",
                         @"cos",
                         @"π", 
                         nil];
    
    return [operations containsObject:operation];
}

+ (BOOL)isNoOperandOperation:(NSString *)operation
{
    NSSet *operations = [NSSet setWithObject:@"π"];
    
    return [operations containsObject:operation];
}

+ (BOOL)isTwoOperandOperation:(NSString *)operation
{
    NSSet *operations = [NSSet setWithObjects:
                         @"+", 
                         @"-",
                         @"/",
                         @"*",
                         nil];
    
    return [operations containsObject:operation];                         
}

+ (BOOL)isSingleOperandOperation:(NSString *)operation
{
    NSSet *operations = [NSSet setWithObjects:
                         @"sqrt",
                         @"sin",
                         @"cos",
                         nil];
    
    return [operations containsObject:operation];    
}


- (void) pushVariableOperand:(NSString *)variableOperand
{
    if (![[self class] isOperation:variableOperand]) 
    {
        [self.programStack addObject:variableOperand];   
    }
}

- (double)performOperation:(NSString *)operation;
{
    [self.programStack addObject:operation];
    return [[self class] runProgram:self.program];
}

// if the top thing on the passed stack is an operand, return it
// if the top thing on the passed stack is an operation, evaluate it (recursively)
// does not crash (but returns 0) if stack contains objects other than NSNumber or NSString
+ (double)popOperandOffProgramStack:(NSMutableArray *)stack
{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]])
    {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]])
    {
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffProgramStack:stack] +
            [self popOperandOffProgramStack:stack];
        } else if ([@"*" isEqualToString:operation]) {
            result = [self popOperandOffProgramStack:stack] *
            [self popOperandOffProgramStack:stack];
        } else if ([operation isEqualToString:@"-"]) {
            double subtrahend = [self popOperandOffProgramStack:stack];
            result = [self popOperandOffProgramStack:stack] - subtrahend;
        } else if ([operation isEqualToString:@"/"]) {
            double divisor = [self popOperandOffProgramStack:stack];
            if (divisor) result = [self popOperandOffProgramStack:stack] / divisor;
        } else if ([operation isEqualToString:@"sin"]) {
            result= sin([self popOperandOffProgramStack:stack]);
        } else if ([operation isEqualToString:@"cos"]) {
            result= cos([self popOperandOffProgramStack:stack]);
        } else if ([operation isEqualToString:@"π"]) {
            result= M_PI;
        } else if ([operation isEqualToString:@"sqrt"]) {
            result= sqrt([self popOperandOffProgramStack:stack]);
        } 

    }
    
    return result;
}

// checks to be sure passed program is actually an array
//  then evaluates it by calling popOperandOffProgramStack:
// assumes popOperandOffProgramStack: protects against junk array contents

+ (double)runProgram:(id)program
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self popOperandOffProgramStack:stack];
}

+ (double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues
{
    double result = 0;
    return result;
}

+ (NSString *)descriptionOfTopOfStack:(NSMutableArray *)stack
{
    NSString *description;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]])
    {
        //  it is a number operand
        //  Do something
        NSString *number = [NSString stringWithFormat:@"%1.0f", [topOfStack doubleValue]];
        description = number;
    }
    else if ([topOfStack isKindOfClass:[NSString class]])
    {
        NSString * topString = topOfStack;
        if ([[self class] isOperation:topString]) {
            
            if ([[self class] isNoOperandOperation:topString]) {
                description = topString;
            } else if ([[self class] isSingleOperandOperation:topString]) {
               //   return using function notation
                description = [topString stringByAppendingFormat:@"(%@)", [self descriptionOfTopOfStack:stack]];
            } else if ([[self class] isTwoOperandOperation:topString]) {
                //  return using infix notation
                
                NSString *temp = [topString stringByAppendingFormat:@" %@", [self descriptionOfTopOfStack:stack]];
                description = [[self descriptionOfTopOfStack:stack] stringByAppendingFormat:@" %@",temp];
            }
            
        }
        else {  //  it is a variable operand
            description = topString;
        }
    }
    
    return description;
}

+ (NSString *)descriptionOfProgram:(id)program
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self descriptionOfTopOfStack:stack];

}


+ (NSSet *)variablesUsedInProgram:(id)program
{
    NSSet *variableSet;
    NSMutableSet *tempSet;
        
    if ([program isKindOfClass:[NSArray class]]) {

        NSArray *tempArray = [program copy];
        
        //  iterate array and check if it is a variable
        //  that is, not an operation or a number
        for (int x=0; x<[tempArray count]; x++) {
            
            id obj = [tempArray objectAtIndex:x];
            if ([obj isKindOfClass:[NSString class]]) {
                NSString *item = obj;
                if (![[self class] isOperation:item]) {
                    //  add to variableSet
                    if (!tempSet) {
                        tempSet = [NSMutableSet setWithObject:item]; 
                    }
                    [tempSet addObject:item];
                }
            }
        }
    }   
        
    if (tempSet) {
        variableSet = [tempSet copy];
    }

    return variableSet;
}


@end
