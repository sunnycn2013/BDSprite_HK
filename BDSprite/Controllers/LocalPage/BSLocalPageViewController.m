//
//  BSLocalPageViewController.m
//  BDSprite
//
//  Created by alibaba on 2017/9/27.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSLocalPageViewController.h"
#import "BSTopicCell.h"
#import "BSCacheManager.h"

@interface BSLocalPageViewController ()

@property (nonatomic,strong) NSDictionary * data;

@property (nonatomic,strong) NSArray * keys;

@end

@implementation BSLocalPageViewController

- (instancetype)initWithStyle:(BSLocalPageType)style
{
    self = [super init];
    if (self) {
        self.style = style;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"浏览历史";
    [self.tableView registerClass:[BSTopicCell class] forCellReuseIdentifier:@"BSTopicCell"];
    [self.view addSubview:self.tableView];
    if (self.style == BSLocalPageTypeHistory) {
        self.data = [[BSCacheManager sharedCache] getHisStoryInfo];
    }else{
        self.data = [[BSCacheManager sharedCache] getFavourutesInfo];
    }
    self.keys = [[[self.data.allKeys copy] reverseObjectEnumerator] allObjects];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.keys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"BSTopicCell";
    BSTopicCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSString * key = [self.keys objectAtIndex:indexPath.row];
    BSTopicInfo * model = [BSTopicInfo mj_objectWithKeyValues:[self.data objectForKey:key]];
    cell.topicInfo = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kIPhone6PScale(112);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * key = [self.keys objectAtIndex:indexPath.row];
    BSTopicInfo * model = [BSTopicInfo mj_objectWithKeyValues:[self.data objectForKey:key]];
    [JumpToOtherVCHandler jumpToWebVCWithUrlString:model.topicContentUrl];
}

@end
