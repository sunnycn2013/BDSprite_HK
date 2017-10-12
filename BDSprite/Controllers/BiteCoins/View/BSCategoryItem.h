//
//  BSCategoryItem.h
//  BDSprite
//
//  Created by alibaba on 2017/10/11.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BSCategoryItemStyle){
    BSCategoryItemStyleNormal = 0,
    BSCategoryItemStyleSelected
};

@class BSCategoryItem;
@protocol BSCategoryItemDelegate<NSObject>

- (void)categoryItem:(BSCategoryItem *)categoryItem didSelected:(NSDictionary *)userInfo;

@end

@interface BSCategoryItem : UIView

@property (nonatomic,strong) UIButton * bgButton;
@property (nonatomic,strong) UIView   * indicatorView;
@property (nonatomic,strong) NSString * title;
@property (nonatomic,assign) BSCategoryItemStyle style;
@property (nonatomic,assign) id<BSCategoryItemDelegate> delegate;

@end
