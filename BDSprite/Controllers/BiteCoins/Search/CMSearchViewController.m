//
//  CMSearchViewController.m
//  BDSprite
//
//  Created by alibaba on 2017/11/12.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "CMSearchViewController.h"
#import "BSCoinCell.h"
#import "UMengSocialHandler.h"
#import "BSSearchViewModel.h"
#import "BDCoinDetailViewController.h"

@interface CMSearchViewController ()<UISearchBarDelegate>

@property (nonatomic,strong)UISearchBar * searchBar;

@property (nonatomic,strong) NSArray * data;

@property (nonatomic,strong)BSSearchViewModel * searchViewModel;

@end

@implementation CMSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"币结果";
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar addSubview:self.searchBar];
//    [self.view addSubview:self.searchBar];
    self.tableView.tableHeaderView = self.searchBar;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[BSCoinCell class] forCellReuseIdentifier:@"BSCoinCell"];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchDataWithKeyWord:(NSString *)keyWord
{
    if (!keyWord || !(keyWord.length>0)) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    NSDictionary * params = @{@"pattern" : keyWord,
                              @"symbol" : @"CNY"
                              };
    //pattern=比特&symbol=CNY
    [self.searchViewModel fetchCoinInfo:params completionHandler:^(id data, NSError *error) {
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
    return [self.searchViewModel.coins count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"BSCoinCell";
    BSCoinCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    BSCoinModel * model = [self.searchViewModel.coins objectAtIndex:indexPath.row];
    cell.coinInfo = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kIPhone6PScale(70);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSCoinModel * model = [self.searchViewModel.coins objectAtIndex:indexPath.row];
    BDCoinDetailViewController * detail = [[BDCoinDetailViewController alloc] initWithModel:model];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton = YES;
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar endEditing:YES];
    self.searchBar.showsCancelButton = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString * keyWord = self.searchBar.text;
    [self fetchDataWithKeyWord:keyWord];
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.searchBar endEditing:YES];
        weakSelf.searchBar.showsCancelButton = NO;
    });
}

#pragma mark - set get
- (BSSearchViewModel *)searchViewModel
{
    if (!_searchViewModel) {
        _searchViewModel = [[BSSearchViewModel alloc] init];
    }
    return _searchViewModel;
}

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, kMarginTop, KScreenWidth, 44)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"输入币名搜索";
        _searchBar.showsCancelButton = YES;
        _searchBar.showsScopeBar = YES;
        _searchBar.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    }
    return _searchBar;
}

@end
