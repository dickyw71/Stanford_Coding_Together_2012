//
//  CalculatorProgramsTVC.m
//  Calculator
//
//  Created by CS193p Instructor on 5/1/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import "CalculatorProgramsTVC.h"
#import "FavoriteCalculatorPrograms.h"
#import "CalculatorBrain.h"

@implementation CalculatorProgramsTVC

@synthesize delegate = _delegate;

#pragma mark - View Controller Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[FavoriteCalculatorPrograms favoritePrograms] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Calculator Program Description";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    id program = [[FavoriteCalculatorPrograms favoritePrograms] objectAtIndex:indexPath.row];
    cell.textLabel.text = [@"y = " stringByAppendingString:[CalculatorBrain descriptionOfProgram:program]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id program = [[FavoriteCalculatorPrograms favoritePrograms] objectAtIndex:indexPath.row];
    [self.delegate calculatorProgramsTVC:self didChooseProgram:program];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"setCalculatorProgram"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        id program = [[FavoriteCalculatorPrograms favoritePrograms] objectAtIndex:indexPath.row];
        [segue.destinationViewController performSelector:@selector(setCalculatorProgram:) withObject:program];
    }
}

@end
