//
//  BSLocalCache.m
//  BDSprite
//
//  Created by alibaba on 2017/9/26.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSLocalCache.h"
#import <YYKit/YYCache.h>

static NSString * const BSLocalCacheKey       = @"com.biteSprite.data";   //喜欢的

@interface BSLocalCache ()

@property (nonatomic, strong) YYCache *cache;

@end

@implementation BSLocalCache

+ (instancetype)sharedCache {
    static dispatch_once_t token;
    static BSLocalCache *instance;
    dispatch_once(&token, ^() {
        instance = [[BSLocalCache alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init])
    {
        self.cache = [[YYCache alloc] initWithName:BSLocalCacheKey];
    }
    
    return self;
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key {
    if (!object) {
        [self removeObjectForKey:key];
        return;
    }
    
    [self.cache setObject:object forKey:key withBlock:^{
        DLog(@"BSLocalCache: key(%@)内容缓存成功", key);
    }];
}

- (BOOL)containsObjectForKey:(NSString *)key {
    return [self.cache containsObjectForKey:key];
}

- (id<NSCoding>)objectForKey:(NSString *)key {
    if (key.length <= 0) {
        return nil;
    }
    
    return [self.cache objectForKey:key];
}

- (void)removeObjectForKey:(NSString *)key {
    [self.cache removeObjectForKey:key withBlock:^(NSString * _Nonnull key) {
        DLog(@"BSLocalCache: 清除(%@)对应内容", key);
    }];
}

- (void)removeAllObjectsSynchronized:(BOOL)bSynchronize {
    if (bSynchronize) {
        [self.cache removeAllObjects];
    } else {
        [self.cache removeAllObjectsWithBlock:^{
            NSLog(@"BSLocalCache: 清除所有内容");
        }];
    }
}

- (NSInteger)totalCacheSize
{
    return self.cache.diskCache.totalCost;
}

- (NSInteger)totalCacheCount
{
    return self.cache.diskCache.totalCount;
}
@end
