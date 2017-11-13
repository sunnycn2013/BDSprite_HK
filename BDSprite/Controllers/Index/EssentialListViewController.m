//
//  EssentialListViewController.m
//  BDSprite
//
//  Created by Aufree on 9/21/15.
//  Copyright (c) 2015 ESTGroup. All rights reserved.
//

#import "EssentialListViewController.h"
#import "BSTopicCell.h"
#import "BSTopicViewModel.h"
#import "BDTopicBannerCell.h"

#import "TopicEntity.h"
#import "BSTopicModel.h"
#import "PostTopicViewController.h"
#import "BSWeiboViewController.h"

#import "BSTopicAPI.h"

@interface EssentialListViewController () <UITableViewDataSource,UITableViewDelegate,SFSafariViewControllerDelegate,BDTopicBannerCellDelegate>

@property (nonatomic, strong) BSTopicViewModel *topicViewModel;
@property (nonatomic, strong) BSTopicModel *topicModel;
@property (nonatomic, strong) NSArray *banner;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) BOOL loading;

@end

@implementation EssentialListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"精华";
    self.pageIndex = 1;
    self.loading = NO;
//    self.banner = @[@"https://www.quintar.com/information/747",@"https://www.quintar.com/information/767",@"https://www.quintar.com/information/765"];
    self.banner = @[@"https://m.hexun.com/money/2017-11-07/191545260.html",@"https://www.btctrade.com/bitcoin/3096.html",@"https://www.btctrade.com/bitcoin/3098.html"];
    self.tableView.mj_header = self.refreashHeader;
    self.tableView.mj_footer = self.refreashFooter;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[BSTopicCell class] forCellReuseIdentifier:@"BSTopicCell"];
    [self.tableView registerClass:[BDTopicBannerCell class] forCellReuseIdentifier:@"BDTopicBannerCell"];
    [self.view addSubview:self.tableView];
    [self fetchFirstPageDataSource];
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 24, 24);
    [rightButton setImage:[UIImage imageNamed:@"xiaoxi"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(jumpToMessageAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [self.navigationItem setRightBarButtonItem:rightBar];
}

#pragma mark Check current user client token

- (void)jumpToMessageAction:(UIBarButtonItem *)sender
{
    BSWeiboViewController * message = [[BSWeiboViewController alloc] init];
    [self.navigationController pushViewController:message animated:YES];
}

- (void)checkCurrentUserClientToken {
    [self fetchDataSourceAtPage:1];
    [[CurrentUser Instance] setupClientRequestState:nil];
}

#pragma mark Get Topic Data
- (void)headerRefreshing {
    if (self.loading) {
        return;
    }
    self.loading = YES;
    self.pageIndex = 1;
    [self fetchFirstPageDataSource];
}
- (void)footerRefreshing {
    if (self.loading) {
        return;
    }
    self.pageIndex++;
    self.loading = YES;
    [self fetchDataSourceAtPage:self.pageIndex];
}

- (void)fetchFirstPageDataSource{
    __weak typeof(self) weakself = self;
    self.tableView.hidden = YES;
    [SVProgressHUD show];
    [self.topicViewModel fetchFirstPage:1 completionHandler :^(id data, NSError *error) {
        weakself.loading = NO;
        [weakself.tableView.mj_header endRefreshing];
        if (!error)
        {
            weakself.tableView.hidden = NO;
            [weakself.tableView reloadData];
        }
        [SVProgressHUD dismiss];
    }];
}

- (void)fetchDataSourceAtPage:(NSInteger)atPage {
    __weak typeof(self) weakself = self;
    [SVProgressHUD show];
    [self.topicViewModel fetchTopicInfoPage:atPage completionHandler :^(id data, NSError *error) {
        weakself.loading = NO;
        [weakself.tableView.mj_footer endRefreshing];
        if (!error)
        {
            [weakself.tableView reloadData];
        }
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.topicViewModel.topics count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = nil;
    BSTopicInfo * model = nil;
    if (indexPath.row == 0) {
        cellIdentifier = @"BDTopicBannerCell";
    }else{
        cellIdentifier = @"BSTopicCell";
    }
    BSTopicCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (indexPath.row > 0)
    {
        model = [self.topicViewModel.topics objectAtIndex:indexPath.row-1];
        cell.topicInfo = model;
    }else{
        cell.topicInfo = model;
        [(BDTopicBannerCell *)cell setDelegate:self];

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath. row== 0) {
        return kIPhone6PScale(175);
    }
    return kIPhone6PScale(112);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicEntity *topic = [self.topicViewModel.topics objectAtIndex:indexPath.row];
    NSString * str = [topic.topicContentUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    SFSafariViewController *sfViewController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:str]];
    sfViewController.delegate = self;
    sfViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sfViewController animated:YES];
}

// Done 按钮

- (void)safariViewControllerDidFinish:(nonnull SFSafariViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];

}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

- (void)banner:(BDTopicBannerCell *)cell didSelectItemAtIndex:(NSInteger)index
{
    if (index < self.banner.count) {
        NSString * urlString = [self.banner objectAtIndex:index];
        SFSafariViewController *sfViewController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:urlString]];
        sfViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:sfViewController animated:YES];
    }
}


#pragma mark Right bar button item

//- (void)createRightButtonItem {
//    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"pencil_square_icon"]
//                                                                           style:UIBarButtonItemStylePlain
//                                                                          target:self
//                                                                          action:@selector(jumpToPostTopicVC)];
//    rightBarButtonItem.tintColor = [UIColor colorWithRed:0.502 green:0.776 blue:0.200 alpha:1.000];
//    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
//}

- (void)jumpToPostTopicVC {
    [self checkUserPermissionWithAction:^{
        PostTopicViewController *postTopicVC = [[UIStoryboard storyboardWithName:@"Topic" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"postTopic"];
        [self.navigationController pushViewController:postTopicVC animated:YES];
    }];
}

- (void)checkUserPermissionWithAction:(void (^)(void))completion {
    if ([[CurrentUser Instance] isLogin]) {
        if (completion) completion();
    } else {
        [JumpToOtherVCHandler jumpToLoginVC:completion];
    }
}

#pragma  mark - set

- (BSTopicViewModel *)topicViewModel
{
    if (!_topicViewModel) {
        _topicViewModel = [[BSTopicViewModel alloc] init];
    }
    return _topicViewModel;
}


@end
