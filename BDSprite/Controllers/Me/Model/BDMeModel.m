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
    item01.title = @"红绿涨跌";
    item01.type = BDMeItemTypeSwitch;
    
    BDMeItemModel * item02 = [[BDMeItemModel alloc] init];
    item02.title = @"给我评价";
    item02.type = BDMeItemTypeEvaluation;
    group01.sections = [NSMutableArray arrayWithArray:@[item01,item02]];
    
    BDMeGroupModel * group02 = [[BDMeGroupModel alloc] init];
    group02.headHeight = 30;

    BDMeItemModel * item03 = [[BDMeItemModel alloc] init];
    item03.title = @"当前版本";
    item03.showText = @"v 0.1";
    item03.type = BDMeItemTypeText;
    
    BDMeItemModel * item04 = [[BDMeItemModel alloc] init];
    item04.title = @"关于我们";
    item04.type = BDMeItemTypeAbout;
    group02.sections = [NSMutableArray arrayWithArray:@[item03,item04]];
    
    ////group 4
    BDMeGroupModel * group04 = [[BDMeGroupModel alloc] init];
    group04.headHeight = 30;
    
    BDMeItemModel * weixin = [[BDMeItemModel alloc] init];
    weixin.title = @"加入微信群";
    weixin.type = BDMeItemTypeJoinWeiXin;

    BDMeItemModel * clearCache = [[BDMeItemModel alloc] init];
    clearCache.title = @"清除缓存";
    clearCache.type = BDMeItemTypeCache;
    clearCache.showText = @"0.05M";
    group04.sections = [NSMutableArray arrayWithArray:@[weixin,clearCache]];

    self.items = [NSMutableArray arrayWithObjects:group00,group01,group02,group04, nil];
}
@end
