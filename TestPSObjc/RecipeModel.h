//
//  ReceipeModel.h
//  TestPSObjc
//
//  Created by Dima Gubatenko on 22.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecipeModel : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *siteURLPath;
@property(nonatomic, copy) NSString *ingredients;
@property(nonatomic, copy) NSString *thumbnail;

- (instancetype) initFromJSON:(id)JSON;
@end

NS_ASSUME_NONNULL_END
