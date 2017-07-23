//
//  Utils.h
//  TestPSObjc
//
//  Created by Dima Gubatenko on 22.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ShowTextOnTapCompletion)();

@interface Utils : NSObject
+ (void)showText:(NSString *)text;
+ (void)showText:(NSString *)text time:(NSTimeInterval)time;
+ (void)showText:(NSString *)text time:(NSTimeInterval)time onTap:(nullable ShowTextOnTapCompletion)tap;
@end

NS_ASSUME_NONNULL_END
