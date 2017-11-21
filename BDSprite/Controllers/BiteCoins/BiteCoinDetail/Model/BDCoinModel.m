//
//  BDCoinModel.m
//  BDSprite
//
//  Created by alibaba on 2017/10/31.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BDCoinModel.h"
#import "BDCoinItemModel.h"

@implementation BDCoinModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    self.noteData = [NSMutableArray array];
    self.listData = [NSMutableArray array];
    [self.noteData addObject:@""];
    BDCoinItemModel * item1 = [[BDCoinItemModel alloc] init];
    item1.chinesename = @"比特币";
    item1.englishname = @"biteCoin";
    item1.percent = @"2.38";
    item1.patton = BDCoinFloorHeader;
    NSArray * array01 = @[item1];
    
    BDCoinItemModel * item2 = [[BDCoinItemModel alloc] init];
    item2.information = @"比特儿平台已于10月20日关闭交易，账户资产无法继续提供交易，需要用户尽快把在平台持..";
    item2.patton = BDCoinFloorInfo;
    
    BDCoinItemModel * item3 = [[BDCoinItemModel alloc] init];
    item3.noteTag = @"排名";
    item3.noteValue = @"1";
    item3.patton = BDCoinFloorRank;
    
    BDCoinItemModel * item4 = [[BDCoinItemModel alloc] init];
    item4.noteTag = @"市值";
    item4.noteValue = @"1000，033，00";
    item4.patton = BDCoinFloorVol;
    
    BDCoinItemModel * item5 = [[BDCoinItemModel alloc] init];
    item5.noteTag = @"流通量";
    item5.noteValue = @"1000，222，444";
    item5.patton = BDCoinFloorCirculation;
    NSArray * array02 = @[item2,item3,item4,item5];

    
    BDCoinItemModel * item6 = [[BDCoinItemModel alloc] init];
    item6.marketName = @"BitFineX";
    item6.marketVolume = @"221,2332,22";
    item6.marketURL = @"https://coinmarketcap.com/currencies/ethereum/#markets";
    item6.patton = BDCoinFloorMaket;

    NSArray * array03 = @[item6];

    [self.listData addObject:array01];
    [self.listData addObject:array02];
    [self.listData addObject:array03];

}

MJCodingImplementation

@end
