//
//  BSCacheManager.m
//  BDSprite
//
//  Created by alibaba on 2017/9/26.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSCacheManager.h"
#import "BSLocalCache.h"
#import "BSLocalCacheDefine.h"

@interface BSCacheManager ()

@property (nonatomic,strong) NSMutableDictionary * hisStory;
@property (nonatomic,strong) NSMutableDictionary * favourutes;
@property (nonatomic,strong) BSLocalCache        * localCache;

@end

@implementation BSCacheManager

+ (instancetype)sharedCache {
    static dispatch_once_t token;
    static BSCacheManager *instance;
    dispatch_once(&token, ^() {
        instance = [[BSCacheManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _hisStory = [NSMutableDictionary dictionary];
        _favourutes = [NSMutableDictionary dictionary];
        _localCache = [BSLocalCache sharedCache];
        NSDictionary * his = (NSDictionary *)[_localCache objectForKey:BSLocalCacheHistory];
        NSDictionary * fav = (NSDictionary *)[_localCache objectForKey:BSLocalCacheFavourite];
        if ([his isKindOfClass:[NSDictionary class]]) {
            [_hisStory addEntriesFromDictionary:his];
        }
        if ([fav isKindOfClass:[NSDictionary class]]) {
            [_favourutes addEntriesFromDictionary:fav];
        }
    }
    return self;
}

- (void)saveHistoryNews:(id)object key:(NSString *)key
{
    if (!object || !key) {
        return;
    }
    [self.hisStory setObject:object forKey:key];
    [self.localCache setObject:self.hisStory forKey:BSLocalCacheHistory];
}

- (void)saveFavouriteNews:(id)object key:(NSString *)key
{
    if (!object || !key) {
        return;
    }
    [self.favourutes setObject:object forKey:key];
    [self.localCache setObject:self.favourutes forKey:BSLocalCacheFavourite];
}

- (NSDictionary *)getHisStoryInfo
{
    return self.hisStory;
}

- (NSDictionary *)getFavourutesInfo
{
    return self.favourutes;
}

@end
