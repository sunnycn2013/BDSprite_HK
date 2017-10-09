//
//  BSBaseViewController.h
//  BDSprite
//
//  Created by alibaba on 2017/9/1.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefreshHeader.h>

@interface BSBaseViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MJRefreshNormalHeader *refreashHeader;

@property (nonatomic, strong) MJRefreshBackNormalFooter *refreashFooter;

-(void)headerRefreshing;

-(void)footerRefreshing;

- (void)showActivityIndicatorView;

- (void)removeActivityIndicatorView;

- (void)setShareButton;
@end
