//
//  Server.h
//  TestPSObjc
//
//  Created by Dima Gubatenko on 22.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecipeModel.h"
#import "ServerDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface Server : NSObject
- (instancetype)initWithDelegate:(id<ServerDelegate>)delegate;
- (void)searchText:(void (^)(NSArray<RecipeModel *> *))completion;
- (void)searchText:(NSString *)text completion:(void (^)(NSArray<RecipeModel *> *))completion;
@end

NS_ASSUME_NONNULL_END
