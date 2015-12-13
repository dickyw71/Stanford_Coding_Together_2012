//
//  PsychologistViewController.m
//  Psychologist
//
//  Created by CS193p Instructor on 4/24/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import "PsychologistViewController.h"
#import "HappinessViewController.h"

@interface PsychologistViewController ()

@end

@implementation PsychologistViewController

// tell the right-hand side of the split view to show the given happiness
// will crash if the right hand side of the split view does not respond
// maybe that's good because we'll find that bug early in testing cycle

- (void)showSplitViewDiagnosis:(int)happiness
{
    id detail = [[self.splitViewController viewControllers] lastObject];
    [detail setHappiness:happiness];
}

- (IBAction)happy
{
    [self showSplitViewDiagnosis:90];
}

- (IBAction)sad
{
    [self showSplitViewDiagnosis:10];
}

- (IBAction)meh
{
    [self showSplitViewDiagnosis:50];
}

// prepares a newly-segued-to MVC by setting its happiness

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{
    if ([segue.destinationViewController respondsToSelector:@selector(setHappiness:)]) {
        if ([segue.identifier isEqualToString:@"ShowHappy"]) {
            [segue.destinationViewController setHappiness:90];
        } else if ([segue.identifier isEqualToString:@"ShowSad"]) {
            [segue.destinationViewController setHappiness:10];
        } else {
            [segue.destinationViewController setHappiness:50];
        }
    }
}

// we've set our struts and springs so that we can rotate to any orientation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
