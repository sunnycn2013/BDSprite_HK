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
#import "BDCoinDataProtocol.h"
#import "BDCoinDetailViewModel.h"

@interface BDCoinDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)BSCoinModel * model;
@property (nonatomic,strong)BDCoinModel * data;
@property (nonatomic,strong)BDCoinDetailViewModel * detailViewModel;

@end

@implementation BDCoinDetailViewController

- (instancetype)initWithModel:(BSCoinModel *)model
{
    self = [super init];
    if (self) {
        self.model = model;
        self.title = model.chinesename;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[BDCoinDetailHeaderCell class] forCellReuseIdentifier:BDCoinFloorHeader];
    [self.tableView registerClass:[BDCoinDetailInfoCell class] forCellReuseIdentifier:BDCoinFloorInfo];
    [self.tableView registerClass:[BDCoinDetailMarketCell class] forCellReuseIdentifier:BDCoinFloorMaket];
    
    [self.tableView registerClass:[BDCoinDetailTemplateCell class] forCellReuseIdentifier:BDCoinFloorRank];
    [self.tableView registerClass:[BDCoinDetailTemplateCell class] forCellReuseIdentifier:BDCoinFloorVol];
    [self.tableView registerClass:[BDCoinDetailTemplateCell class] forCellReuseIdentifier:BDCoinFloorCirculation];


    self.data = [[BDCoinModel alloc] init];
    [self.tableView reloadData];
    
    UIButton * favButton = [UIButton buttonWithType:UIButtonTypeCustom];
    favButton.frame = CGRectMake(0, 0, 24, 24);
    [favButton setImage:[UIImage imageNamed:@"bd_favorite_normal"] forState:UIControlStateNormal];
    [favButton addTarget:self action:@selector(enjoyBiteCoin:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * favButtonBar = [[UIBarButtonItem alloc] initWithCustomView:favButton];
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 24, 24);
    [rightButton setImage:[UIImage imageNamed:@"bd_share"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItems = @[rightBar,favButtonBar];
    
    [self loadWebSiteInfo];
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
    self.model.infoBean = nil;
    [[BSCacheManager sharedCache] saveFavouriteNews:self.model key:key];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadWebSiteInfo
{
    NSDictionary * params = @{@"id" : self.model.coin_id ? : @"bitcoin"};
    [SVProgressHUD show];
    __weak typeof(self) weakSelf = self;
    [self.detailViewModel fetchCoinInfo:params completionHandler:^(id data, NSError *error) {
        [SVProgressHUD dismiss];
        if (error) {
            return ;
        }
        if ([data isKindOfClass:[NSArray class]]) {
            [weakSelf.data.listData removeLastObject];
            [weakSelf.data.listData addObject:data];
        }
        [weakSelf.tableView reloadData];
    }];
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
    if ([model.patton isEqualToString:BDCoinFloorMaket]) {
        [(id<BDCoinDataProtocol>)cell setPatton:model.patton];
        [(id<BDCoinDataProtocol>)cell setDataModel:model];
    }else{
        [(id<BDCoinDataProtocol>)cell setPatton:model.patton];
        [(id<BDCoinDataProtocol>)cell setDataModel:self.model];
    }


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

#pragma mark - set get

- (BDCoinDetailViewModel *)detailViewModel
{
    if (!_detailViewModel) {
        _detailViewModel = [[BDCoinDetailViewModel alloc] init];
    }
    return _detailViewModel;
}
@end
