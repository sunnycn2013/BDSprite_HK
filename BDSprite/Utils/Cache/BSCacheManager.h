//
//  BSCacheManager.h
//  BDSprite
//
//  Created by alibaba on 2017/9/26.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSCacheManager : NSObject

+ (instancetype)sharedCache;

- (void)saveHistoryNews:(id)object key:(NSString *)key;

- (void)saveFavouriteNews:(id)object key:(NSString *)key;

- (NSDictionary *)getHisStoryInfo;

- (NSDictionary *)getFavourutesInfo;
@end
