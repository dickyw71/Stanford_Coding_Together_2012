//
//  FavoriteCalculatorPrograms.m
//  Calculator
//
//  Created by CS193p Instructor on 5/1/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import "FavoriteCalculatorPrograms.h"

@implementation FavoriteCalculatorPrograms

#define FAVORITES_KEY @"FavoriteCalculatorPrograms.FavoritesKey"

+ (void)addToFavorites:(id)program
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favoritePrograms = [[defaults objectForKey:FAVORITES_KEY] mutableCopy];
    if (!favoritePrograms) favoritePrograms = [NSMutableArray array];
    [favoritePrograms addObject:program];
    [defaults setObject:favoritePrograms forKey:FAVORITES_KEY];
    [defaults synchronize];
}

+ (NSArray *)favoritePrograms
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:FAVORITES_KEY];
}

@end
