//
//  BaseTabBarViewController.m
//  BDSprite
//
//  Created by Aufree on 9/21/15.
//  Copyright (c) 2015 ESTGroup. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "EssentialListViewController.h"
//#import "TopicListContainerViewController.h"
#import "WiKiListViewController.h"

#import "BSWeiboViewController.h"
#import "BSWebViewController.h"
#import "MeViewController.h"

@interface BaseTabBarViewController () {
    UINavigationController *_essentialNC;
    UINavigationController *_forumNC;
    UINavigationController *_wikiNC;
    UINavigationController *_meNC;
}
@property (nonatomic) NSTimer *refreshUnreadCountTimer;
@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNoticeCount:) name:UpdateNoticeCount object:nil];
    
    self.delegate = self;
    self.view.backgroundColor = RGB(242, 242, 242);
    [self setupTabBarItems];
    [self setupTabBarStyle];
    [self createRefreshUnreadCountTimer];
}

- (void)createRefreshUnreadCountTimer {
    if (!self.refreshUnreadCountTimer) {
        self.refreshUnreadCountTimer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(checkNoticeCount) userInfo:nil repeats:YES];
    }
}

- (void)checkNoticeCount {
    [[CurrentUser Instance] checkNoticeCount];
}

- (void)updateNoticeCount:(NSNotification *)notification {
    NSNumber *unreadCount = notification.userInfo[@"unreadCount"];
    _meNC.tabBarItem.badgeValue = unreadCount.integerValue > 0 ? unreadCount.stringValue : nil;
}

- (void)setupTabBarItems {
//    UIEdgeInsets insets = UIEdgeInsetsMake(6.0, 0.0, -6.0, 0.0);
    UIEdgeInsets insets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);


    
    EssentialListViewController *essentialListVC = [[EssentialListViewController alloc] init];
    _essentialNC = [[UINavigationController alloc] initWithRootViewController:essentialListVC];
    _essentialNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"bar2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:@"barSE2"]];
    _essentialNC.tabBarItem.imageInsets = insets;
    _essentialNC.tabBarItem.title = @"精华";
    
    WiKiListViewController *wikiListVC = [[WiKiListViewController alloc] init];
    _wikiNC = [[UINavigationController alloc] initWithRootViewController:wikiListVC];
    _wikiNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"bar1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:@"barSE1"]];
    _wikiNC.tabBarItem.imageInsets = UIEdgeInsetsMake(1.0, 0.0, -1.0, 0.0);
    _wikiNC.tabBarItem.title = @"币行情";
    
//    TopicListContainerViewController *topicListContainerVC = [[TopicListContainerViewController alloc] init];
//    _forumNC = [[UINavigationController alloc] initWithRootViewController:topicListContainerVC];
//    _forumNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"forum_icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:@"forum_selected_icon.png"]];
//    _forumNC.tabBarItem.imageInsets = insets;
//    _forumNC.tabBarItem.title = @"消息";
    BSWeiboViewController *topicListContainerVC = [[BSWeiboViewController alloc] init];
    _forumNC = [[UINavigationController alloc] initWithRootViewController:topicListContainerVC];
    _forumNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"bar3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:@"barSE3"]];
    _forumNC.tabBarItem.imageInsets = insets;
    _forumNC.tabBarItem.title = @"消息";
    
//    _meNC = [[UIStoryboard storyboardWithName:@"Me" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    MeViewController * meViewVC = [[MeViewController alloc] init];
    _meNC = [[UINavigationController alloc] initWithRootViewController:meViewVC];
    _meNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"bar5"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:@"barSE5"]];
    _meNC.tabBarItem.badgeValue = nil;
    _meNC.tabBarItem.imageInsets = insets;
    _meNC.tabBarItem.title = @"我的";
    
    NSArray *controllers = @[_wikiNC,_essentialNC, _forumNC, _meNC];
    [self setViewControllers:controllers];
    
}

- (void)setupTabBarStyle {
    // for shouldSelectViewController, enabling animation for tabbar item clicked.
    [self setDelegate:self];
    
    // White background
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_backgroud"]];
}

#pragma mark - Delegate - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionFade];
    [animation setDuration:0.25];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:
                                  kCAMediaTimingFunctionEaseIn]];
    [self.view.window.layer addAnimation:animation forKey:@"fadeTransition"];

    return YES;
}

- (void)pushToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigation = (UINavigationController *)self.selectedViewController;
        [navigation pushViewController:viewController animated:animated];
    }
}

- (void)presentToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    if([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigation = (UINavigationController *)self.selectedViewController;
        [navigation presentViewController:viewController animated:animated completion:completion];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
