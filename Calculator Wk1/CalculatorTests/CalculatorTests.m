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
    double d = [self.brain performOperation:@"pi"];
    STAssertEqualsWithAccuracy(d, 3.141592653, 0.000001, @"perform pi operation should return correct value");
}

- (void)testClear
{
    [self.brain clear];
}

@end
