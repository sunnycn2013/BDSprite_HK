//
//  BDCoinItemModel.m
//  BDSprite
//
//  Created by alibaba on 2017/10/31.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BDCoinItemModel.h"

NSString * const BDCoinFloorHeader = @"coin_floor_header";
NSString * const BDCoinFloorInfo   = @"coin_floor_infomation";
NSString * const BDCoinFloorUniversal   = @"coin_floor_universal";
NSString * const BDCoinFloorMaket       = @"coin_floor_market";

@implementation BDCoinItemModel

- (CGFloat)heightForRow;
{
    if ([self.patton isEqualToString:BDCoinFloorHeader]) {
        return 130.0;
    }else if ([self.patton isEqualToString:BDCoinFloorInfo]){
        return 100.0;
    }else if ([self.patton isEqualToString:BDCoinFloorUniversal]){
        return 40.0;
    }else if ([self.patton isEqualToString:BDCoinFloorMaket]){
        return 50.0;
    }
    return 100.0;
}

@end
