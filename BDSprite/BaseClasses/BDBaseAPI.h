//
//  BDBaseModel.h
//  BDSprite
//
//  Created by alibaba on 2017/8/31.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDBaseRequest.h"

@interface BDBaseAPI : NSObject

@property (nonatomic,strong)BDBaseRequest * request;

@property (nonatomic,strong)NSDictionary  * parameters;

@property (nonatomic,assign)BOOL       isLoading;

- (void)postDataCompletionHandler:(void(^)(id data, NSError * error))completion;

- (void)getDataCompletionHandler:(void(^)(id data, NSError * error))completion;

- (NSString *)host;

- (NSString *)functionID;

//- (NSDictionary *)parameters;

- (void)cancel;

@end


