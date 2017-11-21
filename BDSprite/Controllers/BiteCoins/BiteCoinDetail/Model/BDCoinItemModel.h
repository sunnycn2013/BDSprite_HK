//
//  BDCoinItemModel.h
//  BDSprite
//
//  Created by alibaba on 2017/10/31.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * BDCoinFloorHeader;
extern NSString * BDCoinFloorInfo;
extern NSString * BDCoinFloorUniversal;
extern NSString * BDCoinFloorMaket;

extern NSString * BDCoinFloorRank;
extern NSString * BDCoinFloorVol;
extern NSString * BDCoinFloorCirculation;

@interface BDCoinItemModel : NSObject

@property (nonatomic,strong) NSString * chinesename;
@property (nonatomic,strong) NSString * englishname;
@property (nonatomic,strong) NSString * market_type;
@property (nonatomic,strong) NSString * percent;
@property (nonatomic,strong) NSString * price;

@property (nonatomic,strong) NSString * information;
@property (nonatomic,strong) NSString * rank;
@property (nonatomic,strong) NSString * marketValue;
@property (nonatomic,strong) NSString * onLineTime;

@property (nonatomic,strong) NSString * marketName;
@property (nonatomic,strong) NSString * marketURL;
@property (nonatomic,strong) NSString * marketVolume;

@property (nonatomic,strong) NSString * noteTag;
@property (nonatomic,strong) NSString * noteValue;

#pragma mark - siteinfo?id=bitcoin
@property (nonatomic,strong) NSString * marketSymbol;
@property (nonatomic,strong) NSString * platform;
@property (nonatomic,strong) NSString * symbol;
@property (nonatomic,strong) NSString * turnnumber;
@property (nonatomic,strong) NSString * turnvolume;
@property (nonatomic,strong) NSNumber * update_time;
@property (nonatomic,strong) NSString * typeStr;
@property (nonatomic,strong) NSString * url;

@property (nonatomic,strong) NSString * patton;

- (CGFloat)heightForRow;
@end
