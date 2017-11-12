//
//  BDMineCell.h
//  BDSprite
//
//  Created by ccguo on 2017/11/5.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDMineCell : UITableViewCell

@property (nonatomic ,copy)void(^tapBlock)(id obj,UITableViewCell * cell);

- (void)fillData:(id)model;

- (void)clearText;

@end
