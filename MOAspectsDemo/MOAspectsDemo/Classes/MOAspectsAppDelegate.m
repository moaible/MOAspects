//
//  MOAspectsAppDelegate.m
//  MOAspectsDemo
//
//  Created by Hiromi Motodera on 2015/03/27.
//  Copyright (c) 2015年 MOAI. All rights reserved.
//

#import "MOAspectsAppDelegate.h"

#import "MOAspects.h"
#import "MOAspectsViewController.h"

@interface MOAspectsAppDelegate ()

@end

@implementation MOAspectsAppDelegate

#pragma mark - Property

- (UIWindow *)window
{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.rootViewController = self.navigationController;
    }
    return _window;
}

- (UINavigationController *)navigationController
{
    if (!_navigationController) {
        MOAspectsViewController *viewController = [[MOAspectsViewController alloc] init];
        _navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    }
    return _navigationController;
}

#pragma makr - Application Life cycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self.window makeKeyAndVisible];
    return YES;
}

@end
