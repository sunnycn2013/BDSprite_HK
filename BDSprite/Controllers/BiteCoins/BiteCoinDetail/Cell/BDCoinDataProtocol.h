//
//  BDCoinDataProtocol.h
//  BDSprite
//
//  Created by alibaba on 2017/11/14.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BSCoinModel;
@protocol BDCoinDataProtocol <NSObject>

@property (nonatomic,strong)BSCoinModel * dataModel;
@property (nonatomic,strong)NSString    * patton;

@end
