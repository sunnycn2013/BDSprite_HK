//
//  BSWebViewController.m
//  BDSprite
//
//  Created by alibaba on 2017/9/20.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSWebViewController.h"
#import "UMengSocialHandler.h"
#import "BSBottomView.h"
#import "TopicVoteView.h"
#import "BSCacheManager.h"
#import "UMengSocialHandler.h"

@interface BSWebViewController ()<BSBottomViewDelegate>
@property (nonatomic, strong) BSBottomView *bottomView;
@property (nonatomic, strong) NSDictionary * shareInfo;
@end

@implementation BSWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bottomView];
    [self.bottomView bringSubviewToFront:self.webView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView.backgroundColor = [UIColor whiteColor];
    if ([self.params objectForKey:@"url"] && self.url.absoluteString) {
        NSString * key = self.url.absoluteString ? : @"";
        NSDictionary * dic = self.params ? : @{};
        [[BSCacheManager sharedCache] saveHistoryNews:dic key:key];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shareToFriends
{
    NSString * url = self.url.absoluteString ? : @"www.icaibei.com";
    NSString * title = self.params[@"title"] ? : @"bite";
    NSString * text = self.params[@"title"] ? : @"bite";;

    [UMengSocialHandler shareWithShareURL:url shareImageUrl:nil shareTitle:title shareText:text presentVC:self delegate:self];
}

- (void)setShareButton
{
    UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(0, 0, 25, 25);
    [shareButton setImage:[UIImage imageNamed:@"bar_share"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareToFriends) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)copyTopicUrlToClipboard
{
    NSString *topicUrl = self.url.absoluteString;
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = topicUrl;
    [SVProgressHUD showSuccessWithStatus:@"复制成功"];
}
- (void)bottomView:(BSBottomView *)view didSelectItem:(NSInteger)index
{
    if (index == 0) {
        [self shareToFriends];
    }else if (index == 1){
        [self copyTopicUrlToClipboard];
    }else if (index == 2){
        if ([self.params objectForKey:@"url"] && self.url.absoluteString) {
            NSString * key = self.url.absoluteString ? : @"";
            NSDictionary * dic = self.params ? : @{};
            [[BSCacheManager sharedCache] saveFavouriteNews:dic key:key];
        }
        [SVProgressHUD showInfoWithStatus:@"已经加入收藏夹"];
    }else{
        [SVProgressHUD showInfoWithStatus:@"赞"];
    }
}

#pragma mark -  set get
- (BSBottomView *)bottomView
{
  if(!_bottomView){
      _bottomView = [[BSBottomView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 44-64, SCREEN_WIDTH, 44)];
      _bottomView.backgroundColor = [UIColor whiteColor];
      _bottomView.delegate = self;
  }
  return _bottomView;
}

- (void)setHidenBottomView:(BOOL)hidenBottomView
{
    self.bottomView.hidden = hidenBottomView;
}
@end
