//
//  BSCoinViewModel.h
//  BDSprite
//
//  Created by alibaba on 2017/9/1.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSCoinAPI.h"
#import "BSCoinModel.h"

@interface BSCoinViewModel : NSObject

@property (nonatomic,strong) BSCoinAPI * request;

@property (nonatomic,strong) NSMutableArray * coins;

- (void)fetchFirstPageCoinInfo:(NSInteger)page completionHandler:(void(^)(id data, NSError * error))handler;

- (void)fetchCoinInfoPage:(NSInteger)page completionHandler:(void(^)(id data, NSError * error))handler;

@end
