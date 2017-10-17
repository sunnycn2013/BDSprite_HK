//
//  AppDelegate.m
//  BDSprite
//
//  Created by Aufree on 9/21/15.
//  Copyright (c) 2015 ESTGroup. All rights reserved.
//

#import "AppDelegate.h"
#import "NSURL+QueryDictionary.h"

#import "UMFeedback.h"
#import "UMOpus.h"
#import "UMengSocialHandler.h"
#import "LaunchScreenAdHandler.h"
#import "ExceptionHandler.h"
#import "SAMKeychain.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotifications/UNUserNotificationCenter.h>
#import <UMSocialCore/UMSocialCore.h>

#import "MTAManager.h"
#import "BuglyManager.h"
#import "XGManager.h"
#import "XGPush.h"
#import "XGSetting.h"

@interface AppDelegate ()<UIApplicationDelegate,UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

#pragma mark - Application delegate

/*
 
 {
 "UIApplicationLaunchOptionsRemoteNotificationKey": {
    "aps": {
 "alert": {
 "body": "sdsd",
 "subtitle": "sdsdsd",
 "title": "dsds"
 },
 "sound": "default"
 },
 "xg": {
 "bid": 0,
 "ts": 1504852547
 }
 }
 }
 
 */
- (void)handlerNotification:(NSDictionary *)userInfo
{
    //type=“WEIBO”，“NEWS”，“COIN”;
//    NSDictionary * info = [userInfo objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    NSDictionary * aps = [userInfo objectForKey:@"aps"];
    NSDictionary * alert = [aps objectForKey:@"alert"];
    NSString * type = [alert objectForKey:@"type"];
    
    if ([type isEqualToString:@"WEIBO"]) {
        NSString * wbid = [alert objectForKey:@"weiboid"];
        NSString * url = [NSString stringWithFormat:@"https://m.weibo.cn/status/%@",wbid];
        [JumpToOtherVCHandler jumpToWebVCWithUrlString:url];
    }else if([type isEqualToString:@"NEWS"]){
        NSString * url = [alert objectForKey:@"weiboid"];
        [JumpToOtherVCHandler jumpToWebVCWithUrlString:url];
    }else if([type isEqualToString:@"COIN"]){
        NSString * url = [NSString stringWithFormat:@"https://bter.com/trade/%@",[alert objectForKey:@"englishname"]];// ;
        [JumpToOtherVCHandler jumpToWebVCWithUrlString:url];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Showing the App
    
    [MTAManager initMTA];
    [BuglyManager initBugly];
//    [XGManager initXG];
//    [XGManager handleLaunching:launchOptions];
//    [XGPush startApp:1234567890 appKey:@"ABCDEFGHIJKLMN"];
    
    [[XGSetting getInstance] enableDebug:YES];
//    [XGPush startApp:2200022728 appKey:@"IMJ34Y25JN4I"];
    [XGPush startApp:2200265987 appKey:@"I5RF9SE9Q68B"];
    
    [XGPush isPushOn:^(BOOL isPushOn) {
        NSLog(@"[XGDemo] Push Is %@", isPushOn ? @"ON" : @"OFF");
    }];
    
    [self registerAPNS];
    
//    [XGPush handleLaunching:launchOptions successCallback:^{
//        NSLog(@"[XGDemo] Handle launching success");
//    } errorCallback:^{
//        NSLog(@"[XGDemo] Handle launching error");
//    }];

    
    
    [self makeWindowVisible:launchOptions];
    
    // Basic setup
    [self basicSetup];
    if (launchOptions) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:launchOptions.description forKey:@"aa"];
        [userDefaults synchronize];
        [self handlerNotification:launchOptions];
    }
    
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
//    [LaunchScreenAdHandler checkShouldShowLaunchScreenAd];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//    [[CurrentUser Instance] checkNoticeCount];
}

#pragma mark - Make window visible

- (void)makeWindowVisible:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    if (_tabBarViewController == nil){
        _tabBarViewController = [[BaseTabBarViewController alloc] init];
    }
    self.window.rootViewController = _tabBarViewController;
    
    [self.window makeKeyAndVisible];
}

#pragma mark - Basic setup

- (void)basicSetup {

    
    // About feedback
//    [UMFeedback setAppkey:UMENG_APPKEY];
    [UMOpus setAudioEnable:YES];
    
    // Exception Collection
    [ExceptionHandler bootup];
    
    // Change UITextField and UITextView Cursor / Caret Color
    [[UITextField appearance] setTintColor:[UIColor grayColor]];
    [[UITextView appearance] setTintColor:[UIColor grayColor]];
    
    // UMeng Share
    [UMengSocialHandler setup];
    
    // Tracking Server Bootup
//    [AnalyticsHandler bootup];
    
    // Setup Jpush
//    [JpushHandler sendUserIdToAlias];
//    [JpushHandler setupJpush:nil];
    
    // Show launch screen ad
    if ([GVUserDefaults standardUserDefaults].userClientToken) {
        [LaunchScreenAdHandler showLaunchScreenAd];
    }
    
    // Update current user info
    [[CurrentUser Instance] updateCurrentUserInfoIfNeeded];
    
    // SVProgressHUD customized
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    
    // Setup SSKeyChain
    [SAMKeychain setAccessibilityType:kSecAttrAccessibleWhenUnlocked];
}

#pragma mark - Handle url scheme

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url];
    if (result) {
        return result;
    }
    return YES;
}

//#if __IPHONE_OS_VERSION_MAX_ALLOWED > 100000
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响。
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.scheme isEqualToString:@"BDSprite"]) {
        [self captureUrlScheme:url];
        return YES;
    }
    
    // Umeng URL Callback
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url];
    if (result) {
        return result;
    }
    return YES;
}

//- (void)userNotificationCenter:(UNUserNotificationCenter *)center
//didReceiveNotificationResponse:(UNNotificationResponse *)response
//         withCompletionHandler:(void(^)())completionHandler
//{
//    [XGManager handleReceiveNotification:response.notification];
//}

- (void)captureUrlScheme:(NSURL *)url {
    NSString *type = url.host;
    
    NSDictionary *params = [url uq_queryDictionary];
    
    NSNumber *objectId = 0;
    if([params objectForKey:@"id"] != nil) {
        objectId = params[@"id"];
    }
    
    if ([type isEqualToString:@"users"] && objectId.integerValue > 0) {
        [JumpToOtherVCHandler jumpToUserProfileWithUserId:objectId];
    } else if([type isEqualToString:@"topics"] && objectId.integerValue > 0) {
        [JumpToOtherVCHandler jumpToTopicDetailWithTopicId:objectId];
    }
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *deviceTokenStr = [XGPush registerDevice:deviceToken account:nil successCallback:^{
        NSLog(@"[XGDemo] register push success");
        [SVProgressHUD showSuccessWithStatus:@"token regist success!!"];
    } errorCallback:^{
        NSLog(@"[XGDemo] register push error");
    }];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:deviceTokenStr forKey:BS_Device_Token];
    [userDefaults synchronize];
    //    //保存 device token 令牌,并且去掉空格
    NSLog(@"[XGDemo] device token is %@", deviceTokenStr);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"[XGDemo] register APNS fail.\n[XGDemo] reason : %@", error);
}


/**
 收到通知的回调
 
 @param application  UIApplication 实例
 @param userInfo 推送时指定的参数
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"[XGDemo] receive Notification");
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userInfo.description forKey:@"aa"];
    [userDefaults synchronize];
    
    [self handlerNotification:userInfo];

//    NSString * message = [NSString stringWithFormat:@"%@",userInfo.description];
//    [XGPush handleReceiveNotification:userInfo
//                      successCallback:^{
//                          NSLog(@"[XGDemo] Handle receive success");
//                      } errorCallback:^{
//                          NSLog(@"[XGDemo] Handle receive error");
//                      }];
}


/**
 收到静默推送的回调
 
 @param application  UIApplication 实例
 @param userInfo 推送时指定的参数
 @param completionHandler 完成回调
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"[XGDemo] receive slient Notification");
    NSLog(@"[XGDemo] userinfo %@", userInfo);
//    [XGPush handleReceiveNotification:userInfo
//                      successCallback:^{
//                          NSLog(@"[XGDemo] Handle receive success");
//                      } errorCallback:^{
//                          NSLog(@"[XGDemo] Handle receive error");
//                      }];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

// iOS 10 新增 API
// iOS 10 会走新 API, iOS 10 以前会走到老 API
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
// App 用户点击通知的回调
// 无论本地推送还是远程推送都会走这个回调
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler {
    NSDictionary * userInfo = [response.notification.request.content userInfo];
    NSLog(@"[XGDemo] click notification");
    
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    

    [[UNUserNotificationCenter currentNotificationCenter] getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
        NSArray * array = requests;
        NSLog(@"%@",array);
    }];
    
    
    [[UNUserNotificationCenter currentNotificationCenter] getDeliveredNotificationsWithCompletionHandler:^(NSArray<UNNotification *> * _Nonnull notifications) {
        NSArray * array = notifications;
        NSLog(@"%@",array);
    }];

    for (UILocalNotification *notification in localNotifications)
    {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo)
        {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[@"aaa"];
            
            // 如果找到需要取消的通知，则取消
            if (info != nil)
            {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;
            }
        }
    }
    
    [self handlerNotification:userInfo];

//    [XGPush handleReceiveNotification:response.notification.request.content.userInfo
//                      successCallback:^{
//                          NSLog(@"[XGDemo] Handle receive success");
//                      } errorCallback:^{
//                          NSLog(@"[XGDemo] Handle receive error");
//                      }];
    
//    completionHandler();
}

// App 在前台弹通知需要调用这个接口
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    NSLog(@"aa");
//    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}
#endif

- (void)registerAPNS {
    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    if (sysVer >= 10) {
        // iOS 10
        [self registerPush10];
    } else if (sysVer >= 8) {
        // iOS 8-9
        [self registerPush8to9];
    } else {
        // before iOS 8
        [self registerPushBefore8];
    }
#else
    if (sysVer < 8) {
        // before iOS 8
        [self registerPushBefore8];
    } else {
        // iOS 8-9
        [self registerPush8to9];
    }
#endif
}

- (void)registerPush10{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    
    [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
        }
    }];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
#endif
}

- (void)registerPush8to9{
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

- (void)registerPushBefore8{
//#ifdef __IPHONE_8_0
//    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
//#endif
}

#pragma mark - Status bar touch tracking

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    CGPoint location = [[[event allTouches] anyObject] locationInView:[self window]];
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    if (CGRectContainsPoint(statusBarFrame, location)) {
        [self statusBarTouchedAction];
    }
}

- (void)statusBarTouchedAction {
    [[NSNotificationCenter defaultCenter] postNotificationName:DidTapStatusBar object:nil];
}
@end
