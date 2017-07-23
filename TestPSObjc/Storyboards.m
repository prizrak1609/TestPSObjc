//
//  Storyboards.m
//  TestPSObjc
//
//  Created by Dima Gubatenko on 22.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

#import "Storyboards.h"

@implementation Storyboards

+ (UIViewController *)recipesList {
    return [[UIStoryboard storyboardWithName:@"ReceipesList" bundle:nil] instantiateInitialViewController];
}

@end
