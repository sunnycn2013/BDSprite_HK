//
//  BSTopicViewModel.h
//  BDSprite
//
//  Created by alibaba on 2017/9/3.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSTopicModel.h"
#import "BSTopicAPI.h"

@interface BSTopicViewModel : NSObject

@property (nonatomic,strong) BSTopicAPI * request;

@property (nonatomic,strong) NSMutableArray * topics;

- (void)fetchFirstPage:(NSInteger)page completionHandler:(void(^)(id data, NSError * error))handler;

- (void)fetchTopicInfoPage:(NSInteger)page completionHandler:(void(^)(id data, NSError * error))handler;

@end
