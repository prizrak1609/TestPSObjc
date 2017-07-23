//
//  Utils.m
//  TestPSObjc
//
//  Created by Dima Gubatenko on 22.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

#import "Utils.h"
@import CRToast;

@implementation Utils

+ (void)showText:(NSString *)text {
    [self showText:text time:2];
}

+ (void)showText:(NSString *)text time:(NSTimeInterval)time {
    [self showText:text time:time onTap:nil];
}

+ (void)showText:(NSString *)text time:(NSTimeInterval)time onTap:(nullable void (^)())tap {
    NSDictionary<NSString *, id> *const options = @{kCRToastTextKey : text,
                                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                              kCRToastBackgroundColorKey : UIColor.whiteColor,
                                              kCRToastTextColorKey : UIColor.blackColor,
                                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
                                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
                                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionLeft),
                                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionRight),
                                              kCRToastNotificationTypeKey : @(CRToastTypeNavigationBar),
                                              kCRToastNotificationPresentationTypeKey : @(CRToastPresentationTypeCover),
                                              kCRToastTimeIntervalKey : @(time)};
    if(tap) {
        CRToastInteractionResponder *const interaction = [CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeAll
                                                                                                         automaticallyDismiss:YES
                                                                                                                        block:^(CRToastInteractionType interactionType) {
                                                                                                                            tap();
                                                                                                                        }];
        NSMutableDictionary<NSString *, id> *const mutableOptions = [options mutableCopy];
        mutableOptions[kCRToastInteractionRespondersKey] = interaction;
        [CRToastManager showNotificationWithOptions:mutableOptions completionBlock:nil];
        return;
    }
    [CRToastManager showNotificationWithOptions:options completionBlock:nil];
}

@end
