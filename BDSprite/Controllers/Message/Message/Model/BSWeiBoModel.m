//
//  BSSWeiBoModel.m
//  BDSprite
//
//  Created by alibaba on 2017/9/1.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSWeiBoModel.h"

@implementation BSWeiBoModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
                @"fromDevice" : @"from_device",
                @"messageId" : @"id",
                @"fromDevice" : @"from_device",

             };
}

- (NSString *)updateTimeStr
{
//    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[_update_time doubleValue]/1000];
//    // 格式化时间
//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
//    // 毫秒值转化为秒
//    NSString* dateString = [formatter stringFromDate:date];
//    return dateString;
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[_update_time doubleValue]/1000];
    return [NSString stringWithFormat:@"%@以前",[date shortTimeAgoSinceNow]];
}
@end
