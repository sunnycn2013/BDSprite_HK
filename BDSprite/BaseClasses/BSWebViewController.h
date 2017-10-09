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

@end
