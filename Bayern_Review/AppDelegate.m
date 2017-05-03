//
//  AppDelegate.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "AppDelegate.h"
#import "ConfigHeader.h"
#import "RootViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "HomeViewController.h"
#import <IQKeyboardManager.h>
#import "UserManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UserManager manager] getUserInfo];
    [self registIQKeyBoard];
    [self setRootViewController];
    return YES;
}
- (void)setRootViewController{
    self.window = [[UIWindow alloc]initWithFrame:UI_BOUNDS];
    self.sidePaneVC = [[JASidePanelController alloc]init];
    self.sidePaneVC.shouldDelegateAutorotateToVisiblePanel = NO;
    self.sidePaneVC.leftPanel = [LeftViewController new];
    self.sidePaneVC.rightPanel =[RightViewController new];
    self.sidePaneVC.rightGapPercentage =0.9;
    self.sidePaneVC.leftGapPercentage = 0.8;
    self.sidePaneVC.centerPanel = [[UINavigationController alloc]initWithRootViewController:[HomeViewController new]];
    [self.window setRootViewController:self.sidePaneVC];
    [self.window makeKeyAndVisible];
}
- (void)registIQKeyBoard{
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].shouldShowTextFieldPlaceholder = NO;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
