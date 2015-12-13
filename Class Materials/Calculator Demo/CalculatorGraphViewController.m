//
//  CalculatorGraphViewController.m
//  Calculator
//
//  Created by CS193p Instructor.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//

//  This class needs a property called calculatorProgram which
//    represents the currently-showing calculator program.

@interface CalculatorGraphViewController() <CalculatorProgramsTVCDelegate>
@property (nonatomic, weak) UIPopoverController *favoritesPopover;
@end

@synthesize favoritesPopover = _favoritesPopover;

- (IBAction)addToFavorites
{
    [FavoriteCalculatorPrograms addToFavorites:self.calculatorProgram];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Show Calculator Programs"]) {
        if ([segue.destinationViewController isKindOfClass:[CalculatorProgramsTVC class]]) {
            CalculatorProgramsTVC *cptvc = (CalculatorProgramsTVC *)segue.destinationViewController;
            [cptvc setDelegate:self];
        }
        if ([segue isKindOfClass:[UIStoryboardPopoverSegue class]]) {
            [self.favoritesPopover dismissPopoverAnimated:NO];
            UIPopoverController *popover = ((UIStoryboardPopoverSegue *)segue).popoverController;
            self.favoritesPopover = popover;
        }
    }
}

- (void)calculatorProgramsTVC:(CalculatorProgramsTVC *)sender didChooseProgram:(id)program
{
    self.calculatorProgram = program;
}
