//
//  BSWeiBoViewModel.m
//  BDSprite
//
//  Created by alibaba on 2017/9/1.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSWeiBoViewModel.h"
#import "BSWeiBoModel.h"

@implementation BSWeiBoViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _weibos = [NSMutableArray array];
    }
    return self;
}

- (void)fetchFirstPageCoinInfo:(NSInteger)page completionHandler:(void(^)(id data, NSError * error))handler
{
    [self.weibos removeAllObjects];
    [self fetchCoinInfoPage:1 completionHandler:handler];
}

- (void)fetchCoinInfoPage:(NSInteger)page completionHandler:(void(^)(id data, NSError * error))handler
{
    __weak typeof(self) weakSelf = self;
    NSInteger count = (page == 1) ? 1 : 20;
    NSString * start = [NSString stringWithFormat:@"%ld",(page-1) * count+1];
    NSDictionary * params =  @{@"start" : start,@"count" : @"20"};
    self.request.parameters = params;
    [self.request getDataCompletionHandler:^(id data, NSError *error) {
        if (!error) {
            NSMutableArray * array = [NSMutableArray array];
            if ([data isKindOfClass:[NSArray class]]) {
                for (int i =0; i<[(NSArray *)data count]; i++) {
                    NSDictionary * dict = [(NSArray *)data objectAtIndex:i];
                    BSWeiBoModel * model = [BSWeiBoModel mj_objectWithKeyValues:dict];
                    [array addObject:model];
                }
            }
            [weakSelf.weibos addObjectsFromArray:array];
            if (handler) {
                handler(_weibos,error);
            }
        }
    }];
}

#pragma mark - set get
- (BSWeiBoAPI *)request
{
    if (!_request) {
        _request = [[BSWeiBoAPI alloc] init];
    }
    return _request;
}


@end
