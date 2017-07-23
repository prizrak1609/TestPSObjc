//
//  ReceipeModel.m
//  TestPSObjc
//
//  Created by Dima Gubatenko on 22.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

#import "RecipeModel.h"

@implementation RecipeModel
- (instancetype)initFromJSON:(id)json {
    self = [super init];
    if(self) {
        self.title = [json valueForKey:@"title"];
        self.thumbnail = [json valueForKey:@"thumbnail"];
        self.siteURLPath = [json valueForKey:@"href"];
        self.ingredients = [json valueForKey:@"ingredients"];
    }
    return self;
}
@end
