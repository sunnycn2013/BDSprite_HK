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
#import "BDCoinDetailViewController.h"
#import "UMengSocialHandler.h"

#import "CMSearchViewController.h"

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
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"币行情";
    self.pageIndex = 1;
    self.loading = NO;
    [self.view addSubview:self.categoryView];
    self.tableView.mj_header = self.refreashHeader;
    self.tableView.mj_footer = self.refreashFooter;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[BSCoinCell class] forCellReuseIdentifier:@"BSCoinCell"];
    [self.view addSubview:self.tableView];
    [self coinCategoryView:nil didTapedAtIndex:0];
    [self fetchFirstPageDataSource];
    
    CGSize statusBarSize = [UIApplication sharedApplication].statusBarFrame.size;
    CGFloat marginTop = statusBarSize.height + 44;
    self.categoryView.frame = CGRectMake(0, marginTop, KScreenWidth, 44);
    self.tableView.frame = CGRectMake(0, _categoryView.bottom, SCREEN_WIDTH, KScreenHeight);
    
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 24, 24);
    [leftButton setImage:[UIImage imageNamed:@"sousuo"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(openSearchVC:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [self.navigationItem setLeftBarButtonItem:leftBar];
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 24, 24);
    [rightButton setImage:[UIImage imageNamed:@"bd_share"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [self.navigationItem setRightBarButtonItem:rightBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChanged:) name:BDGlobalThemeChangedNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)openSearchVC:(UIBarButtonItem *)sender
{
    CMSearchViewController * search = [[CMSearchViewController alloc] init];
    search.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:search animated:YES];
}

- (void)shareAction:(UIBarButtonItem *)sender
{
    NSString * url = @"www.icaibei.com";
    NSString * title = @"币动精灵";
    NSString * text = @"币动精灵";
    
    [UMengSocialHandler shareWithShareURL:url shareImageUrl:nil shareTitle:title shareText:text presentVC:self delegate:self];
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
    return kIPhone6PScale(70);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSCoinModel * model = [self.coinViewModel.coins objectAtIndex:indexPath.row];
    BDCoinDetailViewController * detail = [[BDCoinDetailViewController alloc] initWithModel:model];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
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

- (void)themeChanged:(NSNotification *)noti
{
    __weak typeof(self) weakself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakself.tableView reloadData];
    });
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
        _categoryView = [[BSCoinCategoryView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, 38)];
        _categoryView.userInteractionEnabled = YES;
        _categoryView.delegate = self;
        _categoryView.backgroundColor = [UIColor whiteColor];
        [_categoryView reloadData];
    }
    return _categoryView;
}

@end
