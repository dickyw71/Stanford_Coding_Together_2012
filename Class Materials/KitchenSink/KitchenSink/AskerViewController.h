//
//  AskerViewController.h
//  KitchenSink
//
//  Created by CS193p Instructor on 5/22/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AskerViewController;

@protocol AskerViewControllerDelegate <NSObject>
- (void)askerViewController:(AskerViewController *)sender
             didAskQuestion:(NSString *)question
               andGotAnswer:(NSString *)answer;
@optional
- (void)askerViewControllerDidCancel:(AskerViewController *)sender;
@end

@interface AskerViewController : UIViewController

@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *answer;

@property (nonatomic, weak) id <AskerViewControllerDelegate> delegate;

@end
