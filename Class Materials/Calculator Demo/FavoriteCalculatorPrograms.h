//
//  FavoriteCalculatorPrograms.h
//  Calculator
//
//  Created by CS193p Instructor on 5/1/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoriteCalculatorPrograms : NSObject

+ (void)addToFavorites:(id)program;
+ (NSArray *)favoritePrograms;

@end
