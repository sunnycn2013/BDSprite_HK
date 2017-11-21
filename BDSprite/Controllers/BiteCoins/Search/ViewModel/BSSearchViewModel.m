//
//  BSSearchViewModel.m
//  BDSprite
//
//  Created by alibaba on 2017/11/14.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSSearchViewModel.h"

@implementation BSSearchViewModel

- (instancetype)init
{
    self = [super init];
    if(self){
        _coins = [NSMutableArray array];
    }
    return self;
}

- (void)fetchCoinInfo:(NSDictionary *)params completionHandler:(void(^)(id data, NSError * error))handler;
{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary * requestParams = [[NSMutableDictionary alloc] initWithDictionary:params];
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
- (BSSearchAPI *)request
{
    if (!_request) {
        _request = [[BSSearchAPI alloc] init];
    }
    return _request;
}
@end
