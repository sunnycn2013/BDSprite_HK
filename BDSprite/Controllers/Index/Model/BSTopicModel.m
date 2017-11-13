//
//  BSTopicModel.m
//  BDSprite
//
//  Created by Aufree on 9/22/15.
//  Copyright (c) 2015 ESTGroup. All rights reserved.
//

#import "BSTopicModel.h"

@implementation BSTopicInfo
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"topicTitle" : @"title",
             @"topicContentUrl" : @"url",
             @"updatimeStr" : @"update_time",
             };
}

- (NSString *)updatimeStr
{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[_updatimeStr doubleValue]/1000];
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    // 毫秒值转化为秒
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

@end

@implementation BSTopicModel

- (instancetype)initWithParams:(id)params
{
    self = [super init];
    if (self) {
        [self initWithData:params];
    }
    return self;
}

- (void)initWithData:(id)data
{
    NSMutableArray * array = [NSMutableArray array];
    if ([data isKindOfClass:[NSArray class]])
    {
        for (int i = 0; i< [(NSArray *)data count]; i++)
        {
            NSDictionary * dict = [(NSArray *)data objectAtIndex:i];
            BSTopicInfo * model = [BSTopicInfo mj_objectWithKeyValues:dict];
            [array addObject:model];
        }
    }
    self.data = array;
}

@end

