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

@interface CMSearchViewController ()

@property (nonatomic,strong) NSArray * data;

@end

@implementation CMSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"币结果";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.mj_header = self.refreashHeader;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[BSCoinCell class] forCellReuseIdentifier:@"BSCoinCell"];
    [self.view addSubview:self.tableView];

    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"bd_share"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [self.navigationItem setRightBarButtonItem:rightBar];
}

- (void)shareAction:(UIBarButtonItem *)sender
{
    NSString * url = @"www.icaibei.com";
    NSString * title = @"币动精灵";
    NSString * text = @"币动精灵";
    
    [UMengSocialHandler shareWithShareURL:url shareImageUrl:nil shareTitle:title shareText:text presentVC:self delegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"BSCoinCell";
    BSCoinCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    BSCoinModel * model = [self.data objectAtIndex:indexPath.row];
    cell.coinInfo = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kIPhone6PScale(70);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    BDCoinDetailViewController * detail = [[BDCoinDetailViewController alloc] init];
//    detail.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:detail animated:YES];
}

@end
