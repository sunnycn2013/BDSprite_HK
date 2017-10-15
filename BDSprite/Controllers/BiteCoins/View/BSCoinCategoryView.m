//
//  BSCoinCategoryView.m
//  BDSprite
//
//  Created by alibaba on 2017/10/10.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSCoinCategoryView.h"
#import "BSCategoryItem.h"

#define BSCoinCategoryViewTag 5000

@interface BSCoinCategoryView ()<UIScrollViewDelegate,BSCategoryItemDelegate>

@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) NSArray * data;

@end

@implementation BSCoinCategoryView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData
{
    NSArray * categorys = @[@"涨跌",@"市值",@"自选"];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:categorys];
    //2.倒序的数组
    self.data = [[array reverseObjectEnumerator] allObjects];;
    [self addSubview:self.scrollView];
    [self reloadData];
}

- (void)reloadData
{
    CGFloat  width = 60;
    CGFloat  height = 44;
    [self.scrollView removeAllSubViews];
    for (int i = 0 ; i < self.data.count; i++)
    {
        NSString * title = [self.data objectAtIndex:i];
        BSCategoryItem * item = [[BSCategoryItem alloc] initWithFrame:CGRectMake(i * 60, 0, width, height)];
        item.tag = i + BSCoinCategoryViewTag;
        item.title = title;
        item.delegate = self;
        [self.scrollView addSubview:item];
    }
    
    self.scrollView.contentSize = CGSizeMake(width * self.data.count, height);
    BSCategoryItem * firstButton = (BSCategoryItem *)[self.scrollView viewWithTag:BSCoinCategoryViewTag + 0];
    if ([firstButton isKindOfClass:[BSCategoryItem class]]) {
        [firstButton setStyle:BSCategoryItemStyleSelected];
    }
}

- (void)resetIndicatorView
{
    NSArray * subViews = [self.scrollView subviews];
    for (BSCategoryItem * item in subViews) {
        if ([item isKindOfClass:[BSCategoryItem class]]) {
            [item setStyle:BSCategoryItemStyleNormal];
        }
    }
}
#pragma mark - BSCategoryItemDelegate

- (void)categoryItem:(BSCategoryItem *)categoryItem didSelected:(NSDictionary *)userInfo
{
    NSInteger index =categoryItem.tag - BSCoinCategoryViewTag;
    //start=1&count=10000&symbol=BTC&sort=volume&desc=false

    NSString * coinCategory = [self.data objectAtIndex:index];
    NSMutableDictionary * infos = [NSMutableDictionary dictionary];
    [infos setObject:coinCategory forKey:@"symbol"];
    [infos setObject:@"false" forKey:@"desc"];
    
    if (index == 0) {
        [infos setObject:@"BTC" forKey:@"symbol"];
        [infos setObject:@"volume" forKey:@"sort"];
    }else if (index == 1){
        [infos setObject:@"BTC" forKey:@"symbol"];
        [infos setObject:@"percent" forKey:@"sort"];
    }
    if([self.delegate respondsToSelector:@selector(coinCategoryView:userInfo:)]){
        [self.delegate coinCategoryView:self userInfo:[infos copy]];
    }
    [self resetIndicatorView];
    [categoryItem setStyle:BSCategoryItemStyleSelected];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"sss");

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"sss");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"aaa");

}
#pragma mark -
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 44)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.clipsToBounds = YES;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

@end
