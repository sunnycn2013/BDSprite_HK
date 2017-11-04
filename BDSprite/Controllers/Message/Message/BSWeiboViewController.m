//
//  BSWeiboViewController.m
//  BDSprite
//
//  Created by alibaba on 2017/9/1.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSWeiboViewController.h"
#import "BSWeiBoCell.h"
#import "BSWeiBoViewModel.h"
#import "BSWeiBoModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "BDMessageDetailViewController.h"

@interface BSWeiboViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)BSWeiBoViewModel * weiboViewModel;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) BOOL loading;

@end

@implementation BSWeiboViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"消息";
    self.pageIndex = 1;
    self.loading = NO;
    self.tableView.mj_header = self.refreashHeader;
    self.tableView.mj_footer = self.refreashFooter;
    [self.tableView registerClass:[BSWeiBoCell class] forCellReuseIdentifier:@"BSWeiBoCell"];
    [self.view addSubview:self.tableView];
    [self fetchFirstPageDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    __weak typeof(self) weakSelf = self;
    self.tableView.hidden = YES;
    [SVProgressHUD show];
    [self.weiboViewModel fetchFirstPageCoinInfo:1 completionHandler:^(id data, NSError *error) {
        self.loading = NO;
        [weakSelf.tableView.mj_header endRefreshing];
        if (!error)
        {
            weakSelf.tableView.hidden = NO;
            [weakSelf.tableView reloadData];
        }
        [SVProgressHUD dismiss];
    }];
}

- (void)fetchDataSourceAtPage:(NSInteger)atPage {
    __weak typeof(self) weakSelf = self;
    [self.weiboViewModel fetchCoinInfoPage:atPage completionHandler:^(id data, NSError *error) {
        self.loading = NO;
        [weakSelf.tableView.mj_footer endRefreshing];
        if (!error)
        {
            [weakSelf.tableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.weiboViewModel.weibos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"BSWeiBoCell";
    BSWeiBoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    BSWeiBoModel * model = [self.weiboViewModel.weibos objectAtIndex:indexPath.row];
    cell.weibo = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kIPhone6PScale(70);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSWeiBoModel * model = [self.weiboViewModel.weibos objectAtIndex:indexPath.row];
    NSString * url = [NSString stringWithFormat:@"https://m.weibo.cn/status/%@",model.wbid];
//    [JumpToOtherVCHandler jumpToWebVCWithUrlString:url];
    NSDictionary * params = @{
                              @"title" : model.wbname ? : @"",
                              @"text" : model.text ? : @"",
                              @"url" : url
                              };
    BDMessageDetailViewController * viewController = [[BDMessageDetailViewController alloc] initWithParams:params];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - set get
- (BSWeiBoViewModel *)weiboViewModel
{
    if (!_weiboViewModel) {
        _weiboViewModel = [[BSWeiBoViewModel alloc] init];
    }
    return _weiboViewModel;
}
@end
