//
//  WiKiListViewController.m
//  BDSprite
//
//  Created by Aufree on 9/22/15.
//  Copyright (c) 2015 ESTGroup. All rights reserved.
//

#import "WiKiListViewController.h"
#import "BSCoinViewModel.h"
#import "BSCoinCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "BSCoinCategoryView.h"

@interface WiKiListViewController ()<UITableViewDelegate,UITableViewDataSource,BSCoinCategoryViewDelegate>{
    UIScrollView *_scrollView;
}

@property (nonatomic,strong)BSCoinViewModel * coinViewModel;
@property (nonatomic,strong)BSCoinCategoryView * categoryView;
@property (nonatomic,strong)NSDictionary * params;

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) BOOL loading;

@end

@implementation WiKiListViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"币行情";
    self.pageIndex = 1;
    self.loading = NO;
    [self.view addSubview:self.categoryView];

    self.tableView.mj_header = self.refreashHeader;
    self.tableView.mj_footer = self.refreashFooter;
    [self.tableView registerClass:[BSCoinCell class] forCellReuseIdentifier:@"BSCoinCell"];
    [self.view addSubview:self.tableView];
    [self coinCategoryView:nil didTapedAtIndex:0];
    [self fetchFirstPageDataSource];
    
    CGSize statusBarSize = [UIApplication sharedApplication].statusBarFrame.size;
    CGFloat marginTop = statusBarSize.height + 44;
    self.categoryView.frame = CGRectMake(0, marginTop, KScreenWidth, 44);
    self.tableView.frame = CGRectMake(0, _categoryView.bottom, SCREEN_WIDTH, KScreenHeight);
}

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
    self.pageIndex = 1;
    self.tableView.hidden = YES;
    [SVProgressHUD show];
    [self.coinViewModel fetchFirstPageCoinInfo:1 params:self.params completionHandler:^(id data, NSError *error) {
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
    self.tableView.hidden = YES;
    [self.coinViewModel fetchCoinInfoPage:atPage params:self.params completionHandler:^(id data, NSError *error) {
        self.loading = NO;
        [weakSelf.tableView.mj_footer endRefreshing];
        if (!error)
        {
            weakSelf.tableView.hidden = NO;
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
    return [self.coinViewModel.coins count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"BSCoinCell";
    BSCoinCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    BSCoinModel * model = [self.coinViewModel.coins objectAtIndex:indexPath.row];
    cell.coinInfo = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kIPhone6PScale(63);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSCoinModel * model = [self.coinViewModel.coins objectAtIndex:indexPath.row];
    NSDictionary * params = @{
                              @"tagname" : model.coin_id ? : @""
                              };
    [JumpToOtherVCHandler jumpToWebVCWithUrlString:model.jumpURL params:params];
}

#pragma mark - BSCoinCategoryViewDelegate
- (void)coinCategoryView:(BSCoinCategoryView *)view didTapedAtIndex:(NSInteger)index
{
    NSMutableDictionary * infos = [NSMutableDictionary dictionary];
    [infos setObject:@"USD" forKey:@"symbol"];
    
    if (index == 1) {
        [infos setObject:@"volume" forKey:@"sort"];
        [infos setObject:@"true" forKey:@"desc"];
    }else if (index == 2){
        [infos setObject:@"percent" forKey:@"sort"];
        [infos setObject:@"false" forKey:@"desc"];
    }
    self.params = [infos copy];
    [self fetchFirstPageDataSource];
}

#pragma mark - set get
- (BSCoinViewModel *)coinViewModel
{
    if (!_coinViewModel) {
        _coinViewModel = [[BSCoinViewModel alloc] init];
    }
    return _coinViewModel;
}

- (BSCoinCategoryView *)categoryView
{
    if (!_categoryView) {
        _categoryView = [[BSCoinCategoryView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, 44)];
        _categoryView.userInteractionEnabled = YES;
        _categoryView.delegate = self;
        _categoryView.backgroundColor = [UIColor whiteColor];
        [_categoryView reloadData];
    }
    return _categoryView;
}

@end
