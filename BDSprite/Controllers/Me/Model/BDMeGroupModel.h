//
//  BDMeGroupModel.h
//  BDSprite
//
//  Created by alibaba on 2017/11/7.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDMeGroupModel : NSObject

@property (nonatomic,assign) CGFloat headHeight;
@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSMutableArray * sections;

@end

@interface BDMeItemModel : NSObject

@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSString * patton;

@end
