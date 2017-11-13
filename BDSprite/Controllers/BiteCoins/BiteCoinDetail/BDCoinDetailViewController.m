//
//  BDCoinDetailViewController.m
//  BDSprite
//
//  Created by alibaba on 2017/10/31.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BDCoinDetailViewController.h"
#import "BDCoinModel.h"
#import "BDCoinItemModel.h"
#import "BDCoinDetailHeaderCell.h"
#import "BDCoinDetailInfoCell.h"
#import "BDCoinDetailTemplateCell.h"
#import "BDCoinDetailMarketCell.h"

#import "BDCoinHeadView.h"
#import "UMengSocialHandler.h"
#import "BSCacheManager.h"

@interface BDCoinDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)BSCoinModel * model;
@property (nonatomic,strong)BDCoinModel * data;

@end

@implementation BDCoinDetailViewController

- (instancetype)initWithModel:(BSCoinModel *)model
{
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.mj_header = self.refreashHeader;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[BDCoinDetailHeaderCell class] forCellReuseIdentifier:BDCoinFloorHeader];
    [self.tableView registerClass:[BDCoinDetailInfoCell class] forCellReuseIdentifier:BDCoinFloorInfo];
    [self.tableView registerClass:[BDCoinDetailTemplateCell class] forCellReuseIdentifier:BDCoinFloorUniversal];
    [self.tableView registerClass:[BDCoinDetailMarketCell class] forCellReuseIdentifier:BDCoinFloorMaket];


    self.data = [[BDCoinModel alloc] init];
    [self.tableView reloadData];
    
    UIButton * favButton = [UIButton buttonWithType:UIButtonTypeCustom];
    favButton.frame = CGRectMake(0, 0, 24, 24);
    [favButton setImage:[UIImage imageNamed:@"bd_favorite_normal"] forState:UIControlStateNormal];
//    [favButton setImage:[UIImage imageNamed:@"bd_favorite_light"] forState:UIControlStateNormal];
    [favButton addTarget:self action:@selector(enjoyBiteCoin:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * favButtonBar = [[UIBarButtonItem alloc] initWithCustomView:favButton];
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 24, 24);
    [rightButton setImage:[UIImage imageNamed:@"bd_share"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItems = @[rightBar,favButtonBar];
}

- (void)shareAction:(UIBarButtonItem *)sender
{
    NSString * url = @"www.icaibei.com";
    NSString * title = @"币动精灵";
    NSString * text = @"币动精灵";
    [UMengSocialHandler shareWithShareURL:url shareImageUrl:nil shareTitle:title shareText:text presentVC:self delegate:self];
}

- (void)enjoyBiteCoin:(UIBarButtonItem *)sender
{
    [SVProgressHUD showInfoWithStatus:@"关注成功！"];
    NSString * key = self.model.coin_id ? : @"tem";
    [[BSCacheManager sharedCache] saveFavouriteNews:self.model key:key];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.data.listData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * array = [self.data.listData objectAtIndex:section];
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array = [self.data.listData objectAtIndex:indexPath.section];
    BDCoinItemModel * model = [array objectAtIndex:indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:model.patton];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray * array = [self.data.listData objectAtIndex:indexPath.section];
    BDCoinItemModel * model = [array objectAtIndex:indexPath.row];
    return [model heightForRow];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BDCoinHeadView * headView = [[BDCoinHeadView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 35)];
    if (section == 1) {
        [headView fillTitle:@"综合信息"];
    }else{
        [headView fillTitle:@"交易市场"];
    }
    return headView;
}

@end
