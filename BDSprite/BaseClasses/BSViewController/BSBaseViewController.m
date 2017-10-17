//
//  BSBaseViewController.m
//  BDSprite
//
//  Created by alibaba on 2017/9/1.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSBaseViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface BSBaseViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation BSBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat version = [[UIDevice currentDevice].systemVersion doubleValue];
    if (version >= 11.0) {
        if (@available(iOS 11.0, *)){
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier];
    }
    return cell;
}

#pragma mark - private method
- (void)headerRefreshing
{
    NSLog(@"aa");
}

-(void)footerRefreshing
{
    NSLog(@"aa");
}

- (void)showActivityIndicatorView
{
    [SVProgressHUD show];
}

- (void)removeActivityIndicatorView
{
    [SVProgressHUD dismiss];
}

- (void)setShareButton
{
    UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(0, 0, 25, 21);
    [shareButton setImage:[UIImage imageNamed:@"caibei_rightbtn_share"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"caibei_rightbtn_shareClick"] forState:UIControlStateSelected];
    [shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}
#pragma mark - set get
- (UITableView *)tableView
{
    if (!_tableView) {
        CGSize statusBarSize = [UIApplication sharedApplication].statusBarFrame.size;
        CGFloat marginTop = statusBarSize.height + 44;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, marginTop, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (MJRefreshNormalHeader *)refreashHeader
{
    if (!_refreashHeader) {
        _refreashHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
        _refreashHeader.lastUpdatedTimeLabel.hidden = YES;
        _refreashHeader.stateLabel.font = [UIFont fontWithName:FontName size:13];
    }
    return _refreashHeader;
}

- (MJRefreshBackNormalFooter *)refreashFooter
{
    if (!_refreashFooter) {
        _refreashFooter = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
        _tableView.mj_footer.ignoredScrollViewContentInsetBottom = 30;
    }
    return _refreashFooter;
}
@end
