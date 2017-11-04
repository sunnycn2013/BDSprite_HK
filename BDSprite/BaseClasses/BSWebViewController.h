//
//  BSWebViewController.h
//  BDSprite
//
//  Created by alibaba on 2017/9/20.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RxWebViewController.h"

@interface BSWebViewController : RxWebViewController

@property (nonatomic,strong)NSDictionary * params;

@property (nonatomic,assign)BOOL hidenBottomView;

- (void)setShareButton;

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder;

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection;

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container;

- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize;

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container;

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator;

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator;

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator;

- (void)setNeedsFocusUpdate;

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context;

- (void)updateFocusIfNeeded;

@end
