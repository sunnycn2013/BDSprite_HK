//
//  BSCoinModel.h
//  BDSprite
//
//  Created by alibaba on 2017/9/1.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSCoininfoBean : NSObject
@property (nonatomic,strong) NSNumber * coinID;
@property (nonatomic,strong) NSString * imageurl;
@property (nonatomic,strong) NSString * symbol;
@end

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
@property (nonatomic,strong) BSCoininfoBean * infoBean;

@property (nonatomic,strong) NSString * timeStr;
@property (nonatomic,strong) NSString * percentStr;
@property (nonatomic,strong) NSString * jumpURL;

@end
