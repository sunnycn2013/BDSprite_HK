//
//  BSBottomView.h
//  BDSprite
//
//  Created by ccguo on 2017/9/24.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSBottomView;
@protocol BSBottomViewDelegate <NSObject>

- (void)bottomView:(BSBottomView *)view didSelectItem:(NSInteger)index;

@end

@interface BSBottomView : UIView

@property (nonatomic,strong) id<BSBottomViewDelegate> delegate;

@end
