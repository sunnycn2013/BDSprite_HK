//
//  BSLocalCache.h
//  BDSprite
//
//  Created by alibaba on 2017/9/26.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSLocalCache : NSObject

+ (instancetype)sharedCache;

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key;

- (BOOL)containsObjectForKey:(NSString *)key;

- (id<NSCoding>)objectForKey:(NSString *)key;

- (void)removeObjectForKey:(NSString *)key;

- (void)removeAllObjectsSynchronized:(BOOL)bSynchronize;
@end
