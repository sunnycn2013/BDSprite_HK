//
//  BDSpriteContext.h
//  BDSprite
//
//  Created by alibaba on 2017/11/12.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * BDGlobalThemeChangedNotification;

@interface BDSpriteContext : NSObject

@property (nonatomic,assign)BOOL isDesRed;

+ (instancetype)sharedInstance;

@end
