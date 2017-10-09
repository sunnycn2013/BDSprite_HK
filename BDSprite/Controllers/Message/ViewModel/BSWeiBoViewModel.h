//
//  BSWeiBoViewModel.h
//  BDSprite
//
//  Created by alibaba on 2017/9/1.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSWeiBoAPI.h"

@interface BSWeiBoViewModel : NSObject

@property (nonatomic,strong) BSWeiBoAPI * request;

@property (nonatomic,strong) NSMutableArray * weibos;

- (void)fetchFirstPageCoinInfo:(NSInteger)page completionHandler:(void(^)(id data, NSError * error))handler;

- (void)fetchCoinInfoPage:(NSInteger)page completionHandler:(void(^)(id data, NSError * error))handler;
@end
