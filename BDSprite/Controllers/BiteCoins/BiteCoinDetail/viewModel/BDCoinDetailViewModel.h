//
//  BDCoinDetailViewModel.h
//  BDSprite
//
//  Created by alibaba on 2017/11/14.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDCoinDetailAPI.h"
#import "BDCoinItemModel.h"

@interface BDCoinDetailViewModel : NSObject

@property (nonatomic,strong) BDCoinDetailAPI * request;

@property (nonatomic,strong) NSMutableArray * coinInfos;

- (void)fetchCoinInfo:(NSDictionary *)params completionHandler:(void(^)(id data, NSError * error))handler;

@end
