//
//  BSTopicViewModel.m
//  BDSprite
//
//  Created by alibaba on 2017/9/3.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSTopicViewModel.h"

#define pageCount 20

@implementation BSTopicViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _topics = [NSMutableArray array];
    }
    return self;
}

- (void)fetchFirstPage:(NSInteger)page completionHandler:(void(^)(id data, NSError * error))handler
{
    [self.topics removeAllObjects];
    [self fetchTopicInfoPage:1 completionHandler:handler];
}

- (void)fetchTopicInfoPage:(NSInteger)page completionHandler:(void(^)(id data, NSError * error))handler
{
    __weak typeof(self) weakSelf = self;
    NSInteger count = (page == 1) ? 1 : 20; //20;
    NSString * start = [NSString stringWithFormat:@"%ld",(page-1) * count+1];
    NSDictionary * params =  @{@"start" : start,@"count" : @"20"};
    self.request.parameters = params;
    //start=2&count=100
    [self.request getDataCompletionHandler:^(id data, NSError *error) {
        if (!error) {
            NSMutableArray * array = [NSMutableArray array];
            if ([data isKindOfClass:[NSArray class]]) {
                for (int i =0; i<[(NSArray *)data count]; i++) {
                    NSDictionary * dict = [(NSArray *)data objectAtIndex:i];
                    BSTopicInfo * model = [BSTopicInfo mj_objectWithKeyValues:dict];
                    [array addObject:model];
                }
            }
            [weakSelf.topics addObjectsFromArray:array];
            if (handler) {
                handler(_topics,error);
            }
        }
    }];
}

#pragma mark - set get
- (BSTopicAPI *)request
{
    if (!_request) {
        _request = [[BSTopicAPI alloc] init];
    }
    return _request;
}

@end
