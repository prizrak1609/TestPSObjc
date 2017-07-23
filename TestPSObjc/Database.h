//
//  Database.h
//  TestPSObjc
//
//  Created by Dima Gubatenko on 22.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecipeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Database : NSObject
- (nullable NSError *)openOrCreate;
- (NSArray<RecipeModel *> *)getAllRecipesWithError:(NSError **)error;
- (nullable NSError *)deleteRecipes;
- (nullable NSError *)createRecipes:(NSArray<RecipeModel *> *) recipes;
@end

NS_ASSUME_NONNULL_END
