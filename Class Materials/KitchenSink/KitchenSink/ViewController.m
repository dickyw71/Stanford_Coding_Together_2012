//
//  ViewController.m
//  KitchenSink
//
//  Created by CS193p Instructor on 5/22/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import "ViewController.h"
#import "AskerViewController.h"

@interface ViewController () <AskerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *kitchenSink;
@end

@implementation ViewController

@synthesize kitchenSink = _kitchenSink;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Create Label"]) {
        AskerViewController *asker = (AskerViewController *)segue.destinationViewController;
        asker.delegate = self;
        asker.question = @"What text do you want in your label?";
    }
}

- (void)askerViewController:(AskerViewController *)sender
             didAskQuestion:(NSString *)question
               andGotAnswer:(NSString *)answer
{
    [self addLabel:answer];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)askerViewControllerDidCancel:(AskerViewController *)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)addLabel:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:48.0];
    label.backgroundColor = [UIColor clearColor];
    [self setRandomLocationForView:label];
    [self.kitchenSink addSubview:label];
}

- (void)setRandomLocationForView:(UIView *)view
{
    [view sizeToFit];
    CGRect sinkBounds = CGRectInset(self.kitchenSink.bounds, view.frame.size.width/2, view.frame.size.height/2);
    CGFloat x = arc4random() % (int)sinkBounds.size.width + view.frame.size.width/2;
    CGFloat y = arc4random() % (int)sinkBounds.size.height + view.frame.size.height/2;
    view.center = CGPointMake(x, y);
}

#define MOVE_ANIMATION_DURATION 3.0

- (IBAction)tap:(UITapGestureRecognizer *)sender
{
    for (UIView *view in self.kitchenSink.subviews) {
        CGPoint tapLocation = [sender locationInView:self.kitchenSink];
        if (CGRectContainsPoint(view.frame, tapLocation)) {
            [UIView animateWithDuration:MOVE_ANIMATION_DURATION animations:^{
                [self setRandomLocationForView:view];
            }];
        }
    }
}

- (void)viewDidUnload
{
    [self setKitchenSink:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
