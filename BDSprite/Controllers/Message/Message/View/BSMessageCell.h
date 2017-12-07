//
//  BSMessageCell.h
//  BDSprite
//
//  Created by ccguo on 2017/12/7.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSWeiBoModel.h"

@interface BSMessageCell : UITableViewCell

@property (nonatomic,strong)BSWeiBoModel * weibo;

+ (CGFloat)calculateCellHeightWithModel:(BSWeiBoModel *)model;

@end
