//
//  BDSpriteContext.m
//  BDSprite
//
//  Created by alibaba on 2017/11/12.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BDSpriteContext.h"

@implementation BDSpriteContext

+ (instancetype)sharedInstance
{
    static dispatch_once_t token;
    static BDSpriteContext *instance;
    dispatch_once(&token, ^() {
        instance = [[BDSpriteContext alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if(self){
        _isDesRed = YES;
    }
    return self;
}
@end
