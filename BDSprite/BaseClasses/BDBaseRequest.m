//
//  BDBaseApi.m
//  BDSprite
//
//  Created by alibaba on 2017/8/31.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BDBaseRequest.h"
#import "UAUtil.h"

@interface BDBaseRequest ()


@property (nonatomic, strong) AFHTTPSessionManager *request;
@property (nonatomic, strong) NSURL *baseURL;
@end

@implementation BDBaseRequest

+ (instancetype _Nullable )manager
{
    return [[self alloc] initWithBaseURL:nil];
}

- (instancetype _Nullable )initWithBaseURL:(nullable NSString *)urlString
{
    return [self initWithBaseURL:urlString sessionConfiguration:nil];
}

- (instancetype _Nullable )initWithBaseURL:(nullable NSString *)urlString
                      sessionConfiguration:(nullable NSURLSessionConfiguration *)configuration
{
    self = [super init];
    if (self) {
        NSURL * url = nil;
        if (urlString) {
            url = [NSURL URLWithString:urlString];
        }
        self.baseURL = url;
        self.request = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
        self.request.requestSerializer =  [AFHTTPRequestSerializer serializer];
        self.request.responseSerializer =  [AFHTTPResponseSerializer serializer];
        self.request.securityPolicy = [AFSecurityPolicy defaultPolicy];
        self.request.securityPolicy.validatesDomainName = YES;
        self.request.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",@"text/plain",nil];//设置相应内容类型
    }
    return self;
}

- (nullable NSURLSessionDataTask *)GET:(NSString *_Nullable)URLString
                            parameters:(nullable id)parameters
                              progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))downloadProgress
                               success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    NSString * urlstring = [NSString stringWithFormat:@"%@",URLString];
    return [self.request GET:urlstring parameters:parameters progress:downloadProgress
                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    if (success) {
                                        success(task,[UAUtil objectFromData:responseObject]);
                                    }
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    if (failure) {
                                        failure(task,error);
                                    }
                                }];
}

- (nullable NSURLSessionDataTask *)POST:(NSString *_Nullable)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;
{
    NSString * urlstring = [NSString stringWithFormat:@"%@",URLString];
    return [self.request POST:urlstring parameters:parameters progress:uploadProgress
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                     if (success) {
                                         success(task,[UAUtil objectFromData:responseObject]);
                                     }
                                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                     if (failure) {
                                         failure(task,error);
                                     }
                                 }];
    
}

- (nullable NSURLSessionDataTask *)POST:(NSString *_Nullable)URLString
                             parameters:(nullable id)parameters
              constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> _Nullable formData))block
                               progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure
{
    NSString * urlstring = [NSString stringWithFormat:@"%@",URLString];
    return [self.request POST:urlstring parameters:parameters progress:uploadProgress success:success failure:failure];
}

- (void)setRequestSerializer:(AFHTTPRequestSerializer<AFURLRequestSerialization> *)requestSerializer
{
    self.request.requestSerializer = requestSerializer;
}

- (void)setResponseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer
{
    self.request.responseSerializer = responseSerializer;
}

//- (NSString *)rebuildRequestUrlByAPIMethod:(NSString *)apiName
//{
//    UAHttpRequestModel * model = [[UAHttpRequestModel alloc] init];
//    model.method = apiName;
//    return [UAHttpRequestModelManager getServerURL:model];
//}


@end
