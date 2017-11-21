//
//  BDCoinItemModel.m
//  BDSprite
//
//  Created by alibaba on 2017/10/31.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BDCoinItemModel.h"

NSString * BDCoinFloorHeader = @"coin_floor_header";
NSString * BDCoinFloorInfo   = @"coin_floor_infomation";
NSString * BDCoinFloorUniversal   = @"coin_floor_universal";
NSString * BDCoinFloorMaket       = @"coin_floor_market";

NSString * BDCoinFloorRank       = @"coin_floor_rank";
NSString * BDCoinFloorVol       = @"coin_floor_vol";
NSString * BDCoinFloorCirculation = @"coin_floor_circulation";

@implementation BDCoinItemModel

- (CGFloat)heightForRow;
{
    if ([self.patton isEqualToString:BDCoinFloorHeader]) {
        return 130.0;
    }else if ([self.patton isEqualToString:BDCoinFloorInfo]){
        return 110.0;
    }else if ([self.patton isEqualToString:BDCoinFloorUniversal]){
        return 40.0;
    }else if ([self.patton isEqualToString:BDCoinFloorMaket]){
        return 50.0;
    }else if ([self.patton isEqualToString:BDCoinFloorRank]){
        return 40.0;
    }else if ([self.patton isEqualToString:BDCoinFloorVol]){
        return 40.0;
    }else if ([self.patton isEqualToString:BDCoinFloorCirculation]){
        return 40.0;
    }
    return 100.0;
}

MJCodingImplementation

@end
