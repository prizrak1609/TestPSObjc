//
//  AppDelegate.m
//  TestPSObjc
//
//  Created by Dima Gubatenko on 22.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

#import "AppDelegate.h"
@import IQKeyboardManager;
#ifdef DEBUG
@import GDPerformanceView;
#endif
#import "Storyboards.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *) application didFinishLaunchingWithOptions:(NSDictionary *) launchOptions {
    // Override point for customization after application launch.
# pragma mark init keyboard manager
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
# pragma mark set start view controller
    window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    window.rootViewController = Storyboards.recipesList;
    [window makeKeyAndVisible];
# pragma mark init perfomance monitor
#ifdef DEBUG
    [GDPerformanceMonitor sharedInstance].appVersionHidden = YES;
    [GDPerformanceMonitor sharedInstance].deviceVersionHidden = YES;
    [[GDPerformanceMonitor sharedInstance] startMonitoring];
#endif
    return YES;
}

@end
