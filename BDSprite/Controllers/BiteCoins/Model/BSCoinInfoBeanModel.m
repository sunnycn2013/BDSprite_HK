//
//  BSCoinInfoBeanModel.m
//  BDSprite
//
//  Created by alibaba on 2017/11/14.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSCoinInfoBeanModel.h"

@implementation BSCoinInfoBeanModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"coinID" : @"id",
             @"time" : @"update_time",
             @"descriptionInfo":@"description"
             };
}

MJCodingImplementation

@end

