//
//  BSCoinInfoBeanModel.h
//  BDSprite
//
//  Created by alibaba on 2017/11/14.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSCoinInfoBeanModel : NSObject

@property (nonatomic,strong) NSString * coinid;
@property (nonatomic,strong) NSString * imageurl;
@property (nonatomic,strong) NSString * symbol;

@property (nonatomic,strong) NSString * block_stations;
@property (nonatomic,strong) NSString * chinesename;
@property (nonatomic,strong) NSString * cur_num;
@property (nonatomic,strong) NSString * descriptionInfo;

@property (nonatomic,strong) NSString * englishname;
@property (nonatomic,strong) NSString * publish_time;
@property (nonatomic,strong) NSString * total_num;
@property (nonatomic,strong) NSString * websites;

@end

