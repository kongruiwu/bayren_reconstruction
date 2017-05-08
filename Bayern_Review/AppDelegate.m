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
#import "AppKeyDefine.h"
#import "JpushHander.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UserManager manager] getUserInfo];
    [self registIQKeyBoard];
    [self UmengShareSetting];
    [self setRootViewController];
    [self JpushSettingWithDic:launchOptions];
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
- (void)UmengShareSetting{
    [UMSocialManager defaultManager].umSocialAppkey = UmengAppKey;
    [[UMSocialManager defaultManager] openLog:YES];
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppId appSecret:WXAppSecret redirectURL:@"bayren"];
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppId appSecret:nil redirectURL:@"bayren"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Qzone appKey:nil appSecret:QQAppSecret redirectURL:@"bayren"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaAppId  appSecret:SinaAppSecret redirectURL:@"bayren"];
}
- (void)JpushSettingWithDic:(NSDictionary *)launchOptions{
    [JPUSHService setupWithOption:launchOptions appKey:JPUSHKey channel:@"App Store" apsForProduction:YES advertisingIdentifier:nil];
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:JPUSHKey
                          channel:@"App Store"
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [[JpushHander defaultHander] handerPushUserInfo:userInfo withBack:NO vc:[self getCurrentVC]];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [[JpushHander defaultHander] handerPushUserInfo:userInfo withBack:YES vc:[self getCurrentVC]];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    [[JpushHander defaultHander] handerPushUserInfo:userInfo withBack:YES vc:[self getCurrentVC]];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    [[JpushHander defaultHander] handerPushUserInfo:userInfo withBack:NO vc:[self getCurrentVC]];
}


// 在 iOS8 系统中，还需要添加这个方法。通过新的 API 注册推送服务
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
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
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    [JPUSHService setBadge:0];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (UIViewController *)getCurrentVC
{
    JASidePanelController * vc = (JASidePanelController *)self.window.rootViewController;
    return vc.centerPanel;
}

@end
