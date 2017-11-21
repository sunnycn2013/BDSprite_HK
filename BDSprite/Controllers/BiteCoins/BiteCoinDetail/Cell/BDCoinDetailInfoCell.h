//
//  BDCoinDetailInfoCell.h
//  BDSprite
//
//  Created by alibaba on 2017/10/31.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDCoinDataProtocol.h"
#import "BSCoinModel.h"

@interface BDCoinDetailInfoCell : UITableViewCell

@property (nonatomic,strong)BSCoinModel * dataModel;

@property (nonatomic,strong)NSString    * patton;

@end
