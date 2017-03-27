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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:UI_BOUNDS];
    UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:[RootViewController new]];
    LeftViewController  * leftvc = [[LeftViewController alloc]init];
    RightViewController * rightvc = [[RightViewController alloc]init];
    RESideMenu * sidevc = [[RESideMenu alloc]initWithContentViewController:nvc leftMenuViewController:leftvc rightMenuViewController:rightvc];
    sidevc.menuPreferredStatusBarStyle = 1;
    sidevc.delegate = self;
    sidevc.contentViewShadowColor = [UIColor blackColor];
    sidevc.contentViewShadowOffset = CGSizeMake(0, 0);
    sidevc.contentViewShadowOpacity = 0.6;
    sidevc.contentViewShadowRadius = 12;
    sidevc.contentViewShadowEnabled = YES;
    self.window.rootViewController = sidevc;
    
    [self.window setRootViewController:sidevc];
    [self.window makeKeyAndVisible];
    
    return YES;
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