//
//  BDMeGroupModel.h
//  BDSprite
//
//  Created by alibaba on 2017/11/7.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,BDMeItemType){
    BDMeItemTypeDefault = 0,
    BDMeItemTypeSwitch,
    BDMeItemTypeText,
    BDMeItemTypeCache,
    BDMeItemTypeEvaluation,
    BDMeItemTypeAbout,
    BDMeItemTypeJoinWeiXin
};

@interface BDMeGroupModel : NSObject

@property (nonatomic,assign) CGFloat headHeight;
@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSMutableArray * sections;

@end

@interface BDMeItemModel : NSObject

@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSString * patton;
@property (nonatomic,assign) BDMeItemType type;
@property (nonatomic,strong) NSString * showText;
@property (nonatomic,assign) BOOL isClear;

@end
