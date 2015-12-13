//
//  CalcGraphViewController.m
//  Calculator
//
//  Created by Richard Wheatley on 15/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalcGraphViewController.h"
#import "GraphView.h"
#import "CalculatorBrain.h"

@interface CalcGraphViewController () <GraphViewDataSource, UISplitViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet GraphView *graphView;
@end

@implementation CalcGraphViewController 

@synthesize toolbar = _toolbar;
@synthesize graphView = _graphView;
@synthesize plotPoint = _plotPoint;
@synthesize program = _program;

- (void)setGraphView:(GraphView *)graphView
{
    _graphView = graphView;
    //  add gesture recogisers
    [self.graphView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.graphView action:@selector(pinch:)]];
    [self.graphView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self.graphView action:@selector(pan:)]];
    
    
    UITapGestureRecognizer *tripleTap = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self.graphView action:@selector(handleSingleTripleTap:)];
    tripleTap.numberOfTapsRequired = 3;
    [self.graphView addGestureRecognizer:tripleTap];
 
    self.graphView.dataSource = self;

 }

- (void)setProgram:(id)program
{
    _program = program;    
    self.title = [[CalculatorBrain class] descriptionOfProgram:_program];
    [self.graphView setNeedsDisplay];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //   self.splitViewController.presentsWithGesture = NO;
    self.splitViewController.delegate = self;
}

// split view delegation methods
// these will only work if we have an outlet called "toolbar"
// which points to a UIToolbar to put the split view hiding/unhiding UIBarButtonItem into

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return UIInterfaceOrientationIsPortrait(orientation);
}

// called when the master (left) split view pane gets hidden
// make sure to set the master view controller's title in Xcode

- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = @"Calculator";
    NSMutableArray *toolbarItems = [self.toolbar.items mutableCopy];
    [toolbarItems insertObject:barButtonItem atIndex:0];
    self.toolbar.items = toolbarItems;
}

// called when the master (left) split view pane appears

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    NSMutableArray *toolbarItems = [self.toolbar.items mutableCopy];
    [toolbarItems removeObject:barButtonItem];
    self.toolbar.items = toolbarItems;
}

- (void)viewDidUnload {
    [self setGraphView:nil];
    [self setToolbar:nil];
//    [self setToolbar:nil];
    [super viewDidUnload];
}

- (double)valueOfY:(GraphView *)requestor forX:(double)value
{
    double yValue;
    //  runProgram with value of X
    yValue = [[CalculatorBrain class] runProgram:self.program usingVariableValues:[NSDictionary dictionaryWithObject:[NSNumber numberWithDouble:value] forKey:@"x"]];
    
    CGPoint tempPoint;
    tempPoint.x = value;
    tempPoint.y = yValue;
    self.plotPoint = tempPoint;
    
    return yValue;
}

@end
