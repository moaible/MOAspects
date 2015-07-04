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

#pragma mark - Load

+ (void)load
{
    NSArray *selectors = @[NSStringFromSelector(@selector(viewWillAppear:)),
                           NSStringFromSelector(@selector(viewDidAppear:))];
    
    for (NSString *selectorStr in selectors) {
        [MOAspects hookInstanceMethodForClass:[MOAspectsViewController class]
                                     selector:NSSelectorFromString(selectorStr)
                              aspectsPosition:MOAspectsPositionBefore
                                   usingBlock:^(MOAspectsViewController *viewController){
                                       NSString *log = [NSString stringWithFormat:@"-[%@ %@]",
                                                        NSStringFromClass([MOAspectsViewController class]),
                                                        selectorStr];
                                       NSLog(@"%@", log);
                                       viewController.aspectsLogView.text = log;
                                   }];
        [MOAspects hookInstanceMethodForClass:[UINavigationController class]
                                     selector:NSSelectorFromString(selectorStr)
                              aspectsPosition:MOAspectsPositionBefore
                                   usingBlock:^(UINavigationController *viewController){
                                       NSString *log = [NSString stringWithFormat:@"-[%@ %@]",
                                                        NSStringFromClass([UINavigationController class]),
                                                        selectorStr];
                                       NSLog(@"%@", log);
                                   }];
    }
    
    [MOAspects hookInstanceMethodForClass:[UIViewController class]
                                 selector:NSSelectorFromString(@"viewDidLoad")
                          aspectsPosition:MOAspectsPositionAfter
                                hookRange:MOAspectsHookRangeAll
                               usingBlock:^(id object){
                                   NSLog(@"View did loaded from %@", NSStringFromClass([object class]));
                               }];
}

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
