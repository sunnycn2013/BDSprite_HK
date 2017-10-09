//
//  BSLocalPageViewController.h
//  BDSprite
//
//  Created by alibaba on 2017/9/27.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSBaseViewController.h"

typedef NS_ENUM(NSInteger, BSLocalPageType){
    BSLocalPageTypeHistory = 0,
    BSLocalPageTypeFavourite
};

@interface BSLocalPageViewController : BSBaseViewController

@property (nonatomic,assign) BSLocalPageType style;

- (instancetype)initWithStyle:(BSLocalPageType)style;
@end
