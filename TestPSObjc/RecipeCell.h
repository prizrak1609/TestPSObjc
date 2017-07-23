//
//  RecipeCell.h
//  TestPSObjc
//
//  Created by Dima Gubatenko on 22.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecipeCell : UITableViewCell
@property(nonatomic, strong) RecipeModel *model;
@end

NS_ASSUME_NONNULL_END
