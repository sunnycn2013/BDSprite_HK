//
//  BDCoinDetailViewModel.m
//  BDSprite
//
//  Created by alibaba on 2017/11/14.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BDCoinDetailViewModel.h"

@implementation BDCoinDetailViewModel

- (instancetype)init
{
    self = [super init];
    if(self){
        _coinInfos = [NSMutableArray array];
    }
    return self;
}

- (void)fetchCoinInfo:(NSDictionary *)params completionHandler:(void(^)(id data, NSError * error))handler
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
                    BDCoinItemModel * model = [BDCoinItemModel mj_objectWithKeyValues:dict];
                    model.patton = BDCoinFloorMaket;
                    [array addObject:model];
                }
            }
            [weakSelf.coinInfos addObjectsFromArray:array];
            if (handler) {
                handler(_coinInfos,error);
            }
        }
    }];
}
#pragma mark - set get
- (BDCoinDetailAPI *)request
{
    if (!_request) {
        _request = [[BDCoinDetailAPI alloc] init];
    }
    return _request;
}
@end
