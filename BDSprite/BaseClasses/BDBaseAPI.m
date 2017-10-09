//
//  BDBaseModel.m
//  BDSprite
//
//  Created by alibaba on 2017/8/31.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BDBaseAPI.h"

@implementation BDBaseAPI

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isLoading = NO;
        self.request = [BDBaseRequest manager];
    }
    return self;
}

- (void)postDataCompletionHandler:(void(^)(id data, NSError * error))completion
{
    self.isLoading = YES;
    __weak typeof(self) weakSelf = self;
    NSDictionary * params = [self parameters];
    NSString * requestURL = [NSString stringWithFormat:@"%@%@",[self host],[self functionID]];
    [self.request POST:requestURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        weakSelf.isLoading = NO;
        if (completion) {
            completion(responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        if (completion) {
            completion(nil,error);
        }
        weakSelf.isLoading = NO;
    }];
}

- (void)getDataCompletionHandler:(void(^)(id data, NSError * error))completion
{
    self.isLoading = YES;
    __weak typeof(self) weakSelf = self;
    NSLog(@"%@",self.parameters);
    NSDictionary * params = self.parameters;
    NSString * requestURL = [NSString stringWithFormat:@"%@%@",[self host],[self functionID]];
    [self.request GET:requestURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        weakSelf.isLoading = NO;
        if (completion) {
            completion(responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        if (completion) {
            completion(nil,error);
        }
        weakSelf.isLoading = NO;
    }];
}

- (NSString *)host
{
    return @"https://fengzhihen.com/btcapp/";
}

- (NSString *)functionID
{
    return @"";
}

//- (NSDictionary *)parameters
//{
//    return nil;
//}

- (void)cancel
{
//    [self.request c];
}


@end
