//
//  BSSearchViewModel.h
//  BDSprite
//
//  Created by alibaba on 2017/11/14.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSSearchAPI.h"
#import "BSCoinModel.h"

@interface BSSearchViewModel : NSObject

@property (nonatomic,strong) BSSearchAPI * request;

@property (nonatomic,strong) NSMutableArray * coins;

- (void)fetchCoinInfo:(NSDictionary *)params completionHandler:(void(^)(id data, NSError * error))handler;

@end
