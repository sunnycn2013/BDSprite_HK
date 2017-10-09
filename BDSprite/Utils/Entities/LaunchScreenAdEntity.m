//
//  LaunchScreenAdEntity.m
//  BDSprite
//
//  Created by Aufree on 10/19/15.
//  Copyright © 2015 ESTGroup. All rights reserved.
//

#import "LaunchScreenAdEntity.h"

@implementation LaunchScreenAdEntity

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"launchScreenAdId" : @"id",
             @"launchDescription" : @"description",
             @"smallImage" : @"image_small",
             @"bigImage" : @"image_large",
             @"launchScreenType" : @"type",
             @"payload" : @"payload",
             @"displayTime" : @"display_time",
             @"startAt" : @"start_at",
             @"expiresAt" : @"expires_at",
             };
}

#pragma mark - MTLFMDBAdapter Stuff

+ (NSDictionary *)FMDBColumnsByPropertyKey {
    return @{
             @"launchScreenAdId" : @"id",
             @"launchDescription" : [NSNull null],
             @"smallImage" : @"image_small",
             @"bigImage" : @"image_large",
             @"launchScreenType" : @"type",
             @"payload" : @"payload",
             @"displayTime" : @"display_time",
             @"startAt" : @"start_at",
             @"expiresAt" : @"expires_at",
             @"type" : [NSNull null]
             };
}

- (LaunchScreenType)type {
    if (!_type) {
        if ([self.launchScreenType isEqualToString:@"topic"]) {
            _type = LaunchScreenTypeByTopic;
        } else if ([self.launchScreenType isEqualToString:@"user"]) {
            _type = LaunchScreenTypeByUser;
        } else if ([self.launchScreenType isEqualToString:@"web"]) {
            _type = LaunchScreenTypeByWeb;
        } else {
            _type = LaunchScreenTypeUnknow;
        }
    }
    return _type;
}

+ (NSArray *)FMDBPrimaryKeys {
    return @[@"id"];
}

+ (NSString *)FMDBTableName {
    return @"launchScreenAds";
}
@end
