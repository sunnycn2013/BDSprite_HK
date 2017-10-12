//
//  BSCoinViewModel.m
//  BDSprite
//
//  Created by alibaba on 2017/9/1.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSCoinViewModel.h"

@implementation BSCoinViewModel

- (instancetype)init
{
    self = [super init];
    if(self){
        _coins = [NSMutableArray array];
    }
    return self;
}

- (void)fetchFirstPageCoinInfo:(NSInteger)page params:(NSDictionary *)params completionHandler:(void(^)(id data, NSError * error))handler
{
    [self.coins removeAllObjects];
    [self fetchCoinInfoPage:1 params:params completionHandler:handler];
}

- (void)fetchCoinInfoPage:(NSInteger)page params:(NSDictionary *)params completionHandler:(void(^)(id data, NSError * error))handler
{
    __weak typeof(self) weakSelf = self;
    NSInteger count = (page == 1) ? 1 : 20; //20;
    NSString * start = [NSString stringWithFormat:@"%ld",(page-1) * count+1];
    NSDictionary * temParams = @{@"start" : start,@"count" : @"20"};
    NSMutableDictionary * requestParams = [[NSMutableDictionary alloc] initWithDictionary:temParams];
    [requestParams addEntriesFromDictionary:params];
    self.request.parameters = [requestParams copy];
    [self.request getDataCompletionHandler:^(id data, NSError *error) {
        if (!error) {
            NSMutableArray * array = [NSMutableArray array];
            if ([data isKindOfClass:[NSArray class]]) {
                for (int i =0; i<[(NSArray *)data count]; i++) {
                    NSDictionary * dict = [(NSArray *)data objectAtIndex:i];
                    BSCoinModel * model = [BSCoinModel mj_objectWithKeyValues:dict];
                    [array addObject:model];
                }
            }
            [weakSelf.coins addObjectsFromArray:array];
            if (handler) {
                handler(_coins,error);
            }
        }
    }];
}

#pragma mark - set get
- (BSCoinAPI *)request
{
    if (!_request) {
        _request = [[BSCoinAPI alloc] init];
    }
    return _request;
}

@end
