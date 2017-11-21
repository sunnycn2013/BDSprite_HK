//
//  BSCoinModel.h
//  BDSprite
//
//  Created by alibaba on 2017/9/1.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSCoinInfoBeanModel.h"

@interface BSCoinModel : NSObject

@property (nonatomic,strong) NSString * chinesename;
@property (nonatomic,strong) NSString * englishname;
@property (nonatomic,strong) NSNumber * market_type;
@property (nonatomic,strong) NSNumber * percent;
@property (nonatomic,strong) NSNumber * price;
@property (nonatomic,strong) NSNumber * time;
@property (nonatomic,strong) NSString * platform;
@property (nonatomic,strong) NSNumber * turnnumber;
@property (nonatomic,strong) NSNumber * turnvolume;
@property (nonatomic,strong) BSCoinInfoBeanModel * infoBean;
@property (nonatomic,strong) NSString * url;

@property (nonatomic,strong) NSNumber * rank;

#pragma mark - siteinfo?id=bitcoin
@property (nonatomic,strong) NSString * marketSymbol;
@property (nonatomic,strong) NSString * symbol;
@property (nonatomic,strong) NSNumber * update_time;
@property (nonatomic,strong) NSString * typeStr;

@property (nonatomic,strong) NSString * coin_id;
@property (nonatomic,strong) NSString * timeStr;
@property (nonatomic,strong) NSString * percentStr;
@property (nonatomic,strong) NSString * jumpURL;
@property (nonatomic,assign) double   marketValue;

@end
