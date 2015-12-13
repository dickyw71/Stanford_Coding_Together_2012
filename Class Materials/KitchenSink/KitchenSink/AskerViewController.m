//
//  AskerViewController.m
//  KitchenSink
//
//  Created by CS193p Instructor on 5/22/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import "AskerViewController.h"

@interface AskerViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@end

@implementation AskerViewController

@synthesize questionLabel = _questionLabel;
@synthesize answerTextField = _answerTextField;

@synthesize question = _question;
@synthesize answer = _answer;

@synthesize delegate = _delegate;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.question) {
        self.questionLabel.text = @"Unknown Question!";
    } else {
        self.questionLabel.text = self.question;
    }
    [self.answerTextField becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.answerTextField.delegate = self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.answer = self.answerTextField.text;
    [self.delegate askerViewController:self didAskQuestion:self.question andGotAnswer:self.answer];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.answerTextField.text length]) {
        [self.answerTextField resignFirstResponder];
        return YES;
    } else {
        return NO;
    }
}

- (IBAction)cancel
{
    if ([self.delegate respondsToSelector:@selector(askerViewControllerDidCancel:)]) {
        [self.delegate askerViewControllerDidCancel:self];
    } else {
        [self.presentingViewController dismissModalViewControllerAnimated:YES];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)viewDidUnload
{
    [self setQuestionLabel:nil];
    [self setAnswerTextField:nil];
    [super viewDidUnload];
}

@end
