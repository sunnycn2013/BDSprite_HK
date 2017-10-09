//
//  BDBaseApi.h
//  BDSprite
//
//  Created by alibaba on 2017/8/31.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface BDBaseRequest : NSObject

@property (nonatomic, strong,readonly)AFHTTPSessionManager * _Nullable request;

@property (readonly, nonatomic, strong, nullable) NSURL *baseURL;

@property (nonatomic, strong) AFHTTPRequestSerializer <AFURLRequestSerialization> * _Nullable requestSerializer;

@property (nonatomic, strong) AFHTTPResponseSerializer <AFURLResponseSerialization> * _Nullable responseSerializer;

+ (instancetype _Nullable )manager;

- (instancetype _Nullable )initWithBaseURL:(nullable NSString *)urlString;

- (instancetype _Nullable )initWithBaseURL:(nullable NSString *)urlString
                      sessionConfiguration:(nullable NSURLSessionConfiguration *)configuration;

- (nullable NSURLSessionDataTask *)GET:(NSString *_Nullable)URLString
                            parameters:(nullable id)parameters
                              progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))downloadProgress
                               success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;


- (nullable NSURLSessionDataTask *)POST:(NSString *_Nullable)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;
@end
