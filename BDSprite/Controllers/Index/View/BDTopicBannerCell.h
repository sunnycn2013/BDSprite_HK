//
//  BDTopicBannerCell.h
//  BDSprite
//
//  Created by alibaba on 2017/11/12.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSTopicModel.h"

@class BDTopicBannerCell;
@protocol BDTopicBannerCellDelegate<NSObject>

- (void)banner:(BDTopicBannerCell *)cell didSelectItemAtIndex:(NSInteger)index;

@end

@interface BDTopicBannerCell : UITableViewCell

@property (nonatomic,strong)BSTopicInfo * topicInfo;
@property (nonatomic,strong)id<BDTopicBannerCellDelegate> delegate;

@end
