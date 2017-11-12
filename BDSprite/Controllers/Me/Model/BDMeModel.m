//
//  BDMeModel.m
//  BDSprite
//
//  Created by alibaba on 2017/11/7.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BDMeModel.h"
#import "BDMeGroupModel.h"

@implementation BDMeModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData
{
    BDMeGroupModel * group00 = [[BDMeGroupModel alloc] init];
    group00.headHeight = 200;
    
    BDMeGroupModel * group01 = [[BDMeGroupModel alloc] init];
    group01.headHeight = 10;
    
    BDMeItemModel * item01 = [[BDMeItemModel alloc] init];
    item01.title = @"联系我们";
    
    BDMeItemModel * item02 = [[BDMeItemModel alloc] init];
    item02.title = @"给我评价";
    group01.sections = [NSMutableArray arrayWithArray:@[item01,item02]];
    
    BDMeGroupModel * group02 = [[BDMeGroupModel alloc] init];
    group02.headHeight = 30;

    BDMeItemModel * item03 = [[BDMeItemModel alloc] init];
    item03.title = @"当前版本";
    
    BDMeItemModel * item04 = [[BDMeItemModel alloc] init];
    item04.title = @"清楚缓存";
    group02.sections = [NSMutableArray arrayWithArray:@[item03,item04]];

    self.items = [NSMutableArray arrayWithObjects:group00,group01,group02, nil];
}
@end
