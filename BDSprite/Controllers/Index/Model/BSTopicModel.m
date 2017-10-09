//
//  BSTopicModel.m
//  BDSprite
//
//  Created by Aufree on 9/22/15.
//  Copyright (c) 2015 ESTGroup. All rights reserved.
//

#import "BSTopicModel.h"

@implementation BSTopicInfo

//id = 64;
//"new_type" = 2;
//title = "\U9ec4\U5c0f\U7eb2\Uff1a\U533a\U5757\U94fe\U6280\U672f\U63a8\U52a8\U5927\U4e2d\U534e\U7248\U6743\U786e\U7acb";
//"update_time" = 1504178393000;
//url = "http://www.btc38.com/news/2017/8/15243.html";
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

