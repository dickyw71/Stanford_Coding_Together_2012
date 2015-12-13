//
//  ImageViewController.h
//  TopPlaces2
//
//  Created by Richard Wheatley on 29/07/2012.
//  Copyright (c) 2012 Richard Wheatley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSDictionary *photo;
@end
