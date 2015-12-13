//
//  HappinessViewController.m
//  Happiness
//
//  Created by CS193p Instructor on 4/19/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import "HappinessViewController.h"
#import "FaceView.h"

// note that we say we are a UISplitViewControllerDelegate here!
@interface HappinessViewController () <FaceViewDataSource, UISplitViewControllerDelegate>
// outlet to the FaceView in our storyboard used to display our Model
@property (weak, nonatomic) IBOutlet FaceView *faceView;
// outlet (only used on iPad) to put the split view button in
// this toolbar might be a good place to put a button which shows the title of this controller too
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar; // added in LECTURE 7
@end

@implementation HappinessViewController

@synthesize faceView = _faceView;
@synthesize toolbar = _toolbar;
@synthesize happiness = _happiness;

// any time the Model changes, update the View

- (void)setHappiness:(int)happiness
{
    _happiness = happiness;
    [self.faceView setNeedsDisplay];
}

// called when iOS sets our outlet to the FaceView
// add gesture recognizers to the FaceView
// set ourselves as the dataSource of the FaceView so we can provide "smileyness"

- (void)setFaceView:(FaceView *)faceView
{
    _faceView = faceView;
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)]];
    [self.faceView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleHappinessGesture:)]];
    self.faceView.dataSource = self;
}

// implementation of the FaceViewDelegate protocol

- (double)smileForFaceView:(FaceView *)requestor
{
    return (self.happiness - 50) / 50.0;
}

// handler for pan gesture (adjust Model)
// note that "self.happiness =" means call setHappiness: which will setNeedsDisplay on self.faceView

- (void)handleHappinessGesture:(UIPanGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        CGPoint translation = [gesture translationInView:self.faceView];
        self.happiness -= translation.y / 2;
        [gesture setTranslation:CGPointZero inView:self.faceView];
    }
}

// we allow rotation to any orientation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

// LECTURE 7 ADDITIONS

// viewDidLoad is called after all of our outlets are set up
// and we are installed in whatever controller of controllers we're going to be in
// so this is a good place to set ourselves as the delegate of any split view we are in
// setting the split view's presentsWithGesture to NO means swiping does not hide the master
//  (only clicking the toolbar button does)

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
    barButtonItem.title = aViewController.title;
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

// automatically generated when we made the toolbar outlet

- (void)viewDidUnload
{
    [self setToolbar:nil];
    [super viewDidUnload];
}

@end
