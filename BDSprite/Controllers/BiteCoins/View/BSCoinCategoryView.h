//
//  BSCoinCategoryView.h
//  BDSprite
//
//  Created by alibaba on 2017/10/10.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSCoinCategoryView;
@protocol BSCoinCategoryViewDelegate<NSObject>

- (void)coinCategoryView:(BSCoinCategoryView *)view userInfo:(NSDictionary *)userInfo;

@end

@interface BSCoinCategoryView : UIView

- (void)reloadData;

@property (nonatomic,assign) id<BSCoinCategoryViewDelegate> delegate;

@end
