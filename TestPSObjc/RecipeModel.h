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
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *siteURLPath;
@property(nonatomic, strong) NSString *ingredients;
@property(nonatomic, strong) NSString *thumbnail;

- (instancetype) initFromJSON:(id)JSON;
@end

NS_ASSUME_NONNULL_END
