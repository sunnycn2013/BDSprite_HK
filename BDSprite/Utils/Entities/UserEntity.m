//
//  UserEntity.m
//  BDSprite
//
//  Created by Aufree on 9/22/15.
//  Copyright (c) 2015 ESTGroup. All rights reserved.
//

#import "UserEntity.h"

@implementation UserEntity

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"userId" : @"id",
             @"username" : @"name",
             @"avatar" : @"avatar",
             @"topicCount" : @"topic_count",
             @"replyCount" : @"reply_count",
             @"notificationCount" : @"notification_count",
             @"twitterAccount" : @"twitter_account",
             @"company" : @"company",
             @"city" : @"city",
             @"email" : @"email",
             @"introduction" : @"introduction",
             @"githubName" : @"github_name",
             @"githubURL" : @"github_url",
             @"realName" : @"real_name",
             @"blogURL" : @"personal_website",
             @"repliesUrl" : @"links.replies_web_view",
             @"createdAtDate" : @"created_at",
             @"updatedAtDate" : @"updated_at",
             };
}

+ (NSArray *)FMDBPrimaryKeys {
    return @[@"id"];
}

+ (NSString *)FMDBTableName {
    return @"users";
}

#pragma mark - MTLFMDBAdapter

+ (NSDictionary *)FMDBColumnsByPropertyKey {
    return @{
             @"userId" : @"id",
             @"username" : @"name",
             @"avatar" : @"avatar",
             @"topicCount" : @"topic_count",
             @"replyCount" : @"reply_count",
             @"notificationCount" : [NSNull null],
             @"twitterAccount" : @"twitter_account",
             @"company" : @"company",
             @"city" : @"city",
             @"email" : @"email",
             @"introduction" : @"introduction",
             @"githubName" : @"github_name",
             @"githubURL" : @"github_url",
             @"realName" : @"real_name",
             @"blogURL" : @"personal_website",
             @"repliesUrl" : @"replies_web_view",
             @"createdAtDate" : @"created_at",
             @"updatedAtDate" : @"updated_at",
             };
}
@end
