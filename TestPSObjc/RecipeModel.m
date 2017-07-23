//
//  RecipeModel.m
//  TestPSObjc
//
//  Created by Dima Gubatenko on 22.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

#import "RecipeModel.h"

@implementation RecipeModel

@synthesize title;
@synthesize thumbnail;
@synthesize siteURLPath;
@synthesize ingredients;

- (instancetype)initFromJSON:(id)json {
    self = [super init];
    if(self) {
        title = [json valueForKey:@"title"];
        thumbnail = [json valueForKey:@"thumbnail"];
        siteURLPath = [json valueForKey:@"href"];
        ingredients = [json valueForKey:@"ingredients"];
    }
    return self;
}
@end
