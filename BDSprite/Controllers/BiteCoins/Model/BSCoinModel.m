//
//  BSCoinModel.m
//  BDSprite
//
//  Created by alibaba on 2017/9/1.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSCoinModel.h"

@implementation BSCoininfoBean

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"coinID" : @"id",
             @"time" : @"update_time"
             };
}
@end

@implementation BSCoinModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"coinID" : @"id",
             @"time" : @"update_time"
             };
}


- (NSString *)timeStr
{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[_time doubleValue]/1000];
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

- (NSString *)percentStr
{
    NSString * str = @"%";
    double price = [_percent doubleValue];
    if (price > 0) {
        str = [NSString stringWithFormat:@"+ %.2f%@",price * 100,str];
    }else{
        str = [NSString stringWithFormat:@"%.2f%@",price * 100,str];
    }
    return str;
}

- (NSString *)jumpURL
{
    NSString * jumpExt = @"";
    NSString * url = self.platform;
    if ([self.platform rangeOfString:@"jubi"].length > 0) {
        jumpExt = @"coin";
    }else if ([self.platform rangeOfString:@"bter"].length > 0){
        jumpExt = @"trade";
    }
    url = [NSString stringWithFormat:@"%@%@/%@",self.platform,jumpExt,self.englishname];
    if ([url hasPrefix:@"http"]) {
        return url;
    }
    return @"http://m.feixiaohao.com/currencies/ethereum/";
}
@end
