//
//  CalculatorTests.m
//  CalculatorTests
//
//  Created by Richard Wheatley on 28/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorTests.h"
#import "CalculatorBrain.h"

@interface CalculatorTests()
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorTests

@synthesize brain = _brain;

- (void)setUp
{
    [super setUp];
    
    _brain = [[CalculatorBrain alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testValueAfterPerformOperationPlus
{
    [self.brain pushOperand:1.4];
    [self.brain pushOperand:2.6];
    double d = [self.brain performOperation:@"+"];
    STAssertEqualsWithAccuracy(d, 4.0, 0.000001, @"perform plus operation should return correct value");
                               
}

- (void)testValueAfterPerformOperationMultiply
{
    [self.brain pushOperand:1.4];
    [self.brain pushOperand:2.6];
    double d = [self.brain performOperation:@"*"];
    STAssertEqualsWithAccuracy(d, 3.64, 0.000001, @"perform multiply operation should return correct value");
    
}
- (void)testValueAfterPerformOperationMinus
{
    [self.brain pushOperand:1.4];
    [self.brain pushOperand:2.6];
    double d = [self.brain performOperation:@"-"];
    STAssertEqualsWithAccuracy(d, -1.2, 0.000001, @"perform minus operation should return correct value");
    
}

- (void)testValueAfterPerformOperationDivide
{
    [self.brain pushOperand:1.4];
    [self.brain pushOperand:2.6];
    double d = [self.brain performOperation:@"/"];
    STAssertEqualsWithAccuracy(d, 0.53846153846154, 0.000001, @"perform divide operation should return correct value");
    
}

- (void)testValueAfterPerformOperationSine
{
    [self.brain pushOperand:9];
    double d = [self.brain performOperation:@"sin"];
    STAssertEqualsWithAccuracy(d, 0.412118485241757, 0.000001, @"perform sine operation should return correct value");
    
}

- (void)testValueAfterPerformOperationCosine
{
    [self.brain pushOperand:9];
    double d = [self.brain performOperation:@"cos"];
    STAssertEqualsWithAccuracy(d, -0.911130261884677, 0.000001, @"perform cosine operation should return correct value");
    
}

- (void)testValueAfterPerformOperationSqrt
{
    [self.brain pushOperand:9];
    double d = [self.brain performOperation:@"sqrt"];
    STAssertEqualsWithAccuracy(d, 3.0, 0.000001, @"perform sqrt operation should return correct value");    
}

- (void)testValueAfterPerformOperationPi
{ 
    [self.brain pushOperand:9];
    double d = [self.brain performOperation:@"π"];
    STAssertEqualsWithAccuracy(d, 3.141592653, 0.000001, @"perform π (pi) operation should return correct value");
}

- (void)testClear
{
    [self.brain pushOperand:9];
    [self.brain clear];
    double d = [self.brain performOperation:@"sqrt"];
    STAssertEquals(d, 0.0, @"result of operation in empty stack should be 0");
}

- (void)testIsOperation
{

}

- (void)testDescriptionOfProgram
{
    NSArray *stack = [NSArray arrayWithObjects:
                      [NSNumber numberWithDouble:6.0], 
                      [NSNumber numberWithDouble:7.0], 
                      @"+", nil];
    
    STAssertEqualObjects([[self.brain class] descriptionOfProgram:stack], @"6 + 7", @"returned string should equal expected");
    
    
}

- (void)testDescriptionOfProgamVariation2b
{
    NSArray *stack = [NSArray arrayWithObjects:
                      [NSNumber numberWithDouble:3], 
                      [NSNumber numberWithDouble:5], 
                      @"+", 
                      @"sqrt", nil];
    
    STAssertEqualObjects([[self.brain class] descriptionOfProgram:stack], @"sqrt(3 + 5)", @"returned string should equal expected");
    
    
}

- (void)testDescriptionOfProgamVariation2c
{
    NSArray *stack = [NSArray arrayWithObjects:
                      [NSNumber numberWithDouble:3], 
                      @"sqrt",
                      @"sqrt", nil];
    
    STAssertEqualObjects([[self.brain class] descriptionOfProgram:stack], @"sqrt(sqrt(3))", @"returned string should equal expected");
    
}

- (void)testDescriptionOfProgramVariation2d
{
    NSArray *stack = [NSArray arrayWithObjects:
                      [NSNumber numberWithDouble:3], 
                      [NSNumber numberWithDouble:5], 
                      @"sqrt", 
                      @"+", nil];
    
    STAssertEqualObjects([[self.brain class] descriptionOfProgram:stack], @"3 + sqrt(5)", @"returned string should equal expected");
    
}

- (void)testDescriptionOfProgramVariation2e
{
    NSArray *stack = [NSArray arrayWithObjects:
                      @"π", 
                      @"r", 
                      @"r", 
                      @"*",
                      @"*", nil];
    
    STAssertEqualObjects([[self.brain class] descriptionOfProgram:stack], @"π * r * r", @"returned string should equal expected");
}

- (void)testDescriptionOfProgramVariation2f
{
    NSArray *stack = [NSArray arrayWithObjects:
                      @"a", 
                      @"a", 
                      @"*", 
                      @"b",
                      @"b",
                      @"*",
                      @"+",
                      @"sqrt", nil];
    
    STAssertEqualObjects([[self.brain class] descriptionOfProgram:stack], @"sqrt(a * a + b * b)", @"returned string should equal expected");
}

- (void)testDescriptionOfNoOperandOperation
{
    NSArray *stack = [NSArray arrayWithObject:@"π"];
    
    STAssertEqualObjects([[self.brain class] descriptionOfProgram:stack], @"π", @"returned string should equal expected");
}

- (void)testDescriptionOfSingleOperandOperation
{
    NSArray *stack = [NSArray arrayWithObjects:
                      [NSNumber numberWithDouble:9], 
                      @"sqrt", nil];
    
    STAssertEqualObjects([[self.brain class] descriptionOfProgram:stack], @"sqrt(9)", @"returned string should equal expected");
}

- (void)testVariablesUsedInProgramWhenNoVariables
{
    NSSet *variables;
    
    NSArray *stack = [NSArray arrayWithObjects:
                      [NSNumber numberWithDouble:9], 
                      @"sqrt", nil];
    
    variables = [[self.brain class] variablesUsedInProgram:stack];

    STAssertNil(variables, @"should return nil");
}

- (void)testVariablesUsedInProgramWhenVariables
{
    NSSet *variables;
    
    NSArray *stack = [NSArray arrayWithObjects:
                      @"x", 
                      @"y", nil];
    
    variables = [[self.brain class] variablesUsedInProgram:stack];
    
    STAssertTrue([variables containsObject:@"x"], @"should include 'x' in variable set");
    STAssertTrue([variables containsObject:@"y"], @"should include 'y' in variable set");
}

- (void)testVariablesUsedInProgramWhenVariablesAndOperators
{
    NSSet *variables;
    
    NSArray *stack = [NSArray arrayWithObjects:
                      @"+",
                      @"x", 
                      @"y",
                      @"cos", nil];
    
    variables = [[self.brain class] variablesUsedInProgram:stack];
    
    STAssertTrue([variables containsObject:@"x"], @"should include 'x' in variable set");
    STAssertTrue([variables containsObject:@"y"], @"should include 'y' in variable set");
}

- (void)testVariablesUsedInProgramWhenVariablesOperatorsAndOperands
{
    NSSet *variables;
    
    NSArray *stack = [NSArray arrayWithObjects:
                      [NSNumber numberWithDouble:9],
                      @"+",
                      @"x", 
                      [NSNumber numberWithDouble:9],
                      @"y",
                      @"cos", nil];
    
    variables = [[self.brain class] variablesUsedInProgram:stack];
    
    STAssertTrue([variables containsObject:@"x"], @"should include 'x' in variable set");
    STAssertTrue([variables containsObject:@"y"], @"should include 'y' in variable set");
}

@end
