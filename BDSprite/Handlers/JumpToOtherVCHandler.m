//
//  JumpToOtherVCHandler.m
//  BDSprite
//
//  Created by Aufree on 10/8/15.
//  Copyright © 2015 ESTGroup. All rights reserved.
//

#import "JumpToOtherVCHandler.h"

#import "BaseTabBarViewController.h"
#import "TopicDetailViewController.h"
#import "LoginViewController.h"
#import "UserProfileViewController.h"
#import "BSWebViewController.h"
#import "CommentListViewController.h"

#import "AppDelegate.h"

@implementation JumpToOtherVCHandler

+ (UIViewController *)getTabbarViewController {
    BaseTabBarViewController *tabbar = [(AppDelegate *)[[UIApplication sharedApplication] delegate] tabBarViewController];
    return tabbar;
}

+ (void)pushToOtherView:(UIViewController *)vc animated:(BOOL)animated {
    BaseTabBarViewController *tabbar = [(AppDelegate *)[[UIApplication sharedApplication] delegate] tabBarViewController];
    [tabbar pushToViewController:vc animated:YES];
}

+ (void)presentToOtherView:(UIViewController *)vc animated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    BaseTabBarViewController *tabbar = [(AppDelegate *)[[UIApplication sharedApplication] delegate] tabBarViewController];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [tabbar presentViewController:navigationController animated:animated completion:completion];
}

+ (void)jumpToTopicDetailWithTopic:(TopicEntity *)topic {
    TopicDetailViewController *topicDetailVC = [[UIStoryboard storyboardWithName:@"Topic" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"topic"];
    topicDetailVC.topic = topic;
    [self pushToOtherView:topicDetailVC animated:YES];
}

+ (void)jumpToTopicDetailWithTopicId:(NSNumber *)topicId {
    TopicDetailViewController *topicDetailVC = [[UIStoryboard storyboardWithName:@"Topic" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"topic"];
    TopicEntity *topic = [TopicEntity new];
    topic.topicId = topicId;
    topicDetailVC.topic = topic;
    [self pushToOtherView:topicDetailVC animated:YES];
}

+ (void)jumpToUserProfileWithUserId:(NSNumber *)userId {
    UserProfileViewController *userProfileVC = [[UIStoryboard storyboardWithName:@"UserProfile"
                                                                          bundle:[NSBundle mainBundle]]
                                                instantiateViewControllerWithIdentifier:@"userprofile"];
    UserEntity *user = [UserEntity new];
    user.userId = userId;
    userProfileVC.userEntity = user;
    [self pushToOtherView:userProfileVC animated:YES];
}

+ (void)jumpToCommentListVCWithTopic:(TopicEntity *)topic {
    CommentListViewController *commentListVC = [[CommentListViewController alloc] init];
    commentListVC.hidesBottomBarWhenPushed = YES;
    commentListVC.topic = topic;
    [self pushToOtherView:commentListVC animated:YES];
}

+ (void)jumpToWebVCWithUrlString:(NSString *)url {
    BSWebViewController *webVC = [[BSWebViewController alloc] initWithUrl:[NSURL URLWithString:url]];
    webVC.hidesBottomBarWhenPushed = YES;
    [webVC setShareButton];
    [self pushToOtherView:webVC animated:YES];
}

+ (void)jumpToSWebVCWithTopic:(TopicEntity *)topic
{
    NSDictionary * params = @{
                              @"title" : topic.topicTitle ? : @"",
                              @"url" : topic.topicContentUrl ? : @"",
                              @"time" : topic.updatimeStr
                              };
    BSWebViewController *webVC = [[BSWebViewController alloc] initWithUrl:[NSURL URLWithString:topic.topicContentUrl]];
    webVC.hidesBottomBarWhenPushed = YES;
    webVC.params = params;
    [webVC setShareButton];
    [self pushToOtherView:webVC animated:YES];
}

+ (void)jumpToLoginVC:(void (^)(void))completion {
    LoginViewController *loginVC = [[UIStoryboard storyboardWithName:@"Passport"
                                                              bundle:[NSBundle mainBundle]]
                                    instantiateViewControllerWithIdentifier:@"login"];
    loginVC.completeLoginBlock = completion;
    [self presentToOtherView:loginVC animated:YES completion:nil];
}

//+ (void)jumpToSFSafariWithUrlString:(NSString *)url {
//{
//   
//}
@end
