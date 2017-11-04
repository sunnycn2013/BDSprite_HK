//
//  BDCoinItemModel.h
//  BDSprite
//
//  Created by alibaba on 2017/10/31.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const BDCoinFloorHeader;
extern NSString * const BDCoinFloorInfo;

extern NSString * const BDCoinFloorUniversal;
extern NSString * const BDCoinFloorMaket;

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

@property (nonatomic,strong) NSString * patton;

- (CGFloat)heightForRow;
@end
