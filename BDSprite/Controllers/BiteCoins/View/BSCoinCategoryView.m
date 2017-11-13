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
@property (nonatomic,strong) CALayer *lineLayer;

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

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = CGRectMake(0, 0, self.width, self.height-1);
    self.lineLayer.frame = CGRectMake(0, self.height - 1,KScreenWidth, 0.5);
}

- (void)initData
{
    [self addSubview:self.scrollView];
    [self.layer addSublayer:self.lineLayer];
}

- (void)reloadData
{
    self.data = @[@"自选",@"市值",@"涨跌"];
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
        item.backgroundColor = [UIColor clearColor];
        [self.scrollView addSubview:item];
    }
    
    self.scrollView.contentSize = CGSizeMake(width * 3, 44);
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);

    BSCategoryItem * firstButton = (BSCategoryItem *)[self.scrollView viewWithTag:BSCoinCategoryViewTag + 0];
    if ([firstButton isKindOfClass:[BSCategoryItem class]]) {
        [firstButton setStyle:BSCategoryItemStyleSelected];
    }
    NSLog(@"%@",self.scrollView.subviews);
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
    NSInteger index = categoryItem.tag - BSCoinCategoryViewTag;
    if([self.delegate respondsToSelector:@selector(coinCategoryView:didTapedAtIndex:)]){
        [self.delegate coinCategoryView:self didTapedAtIndex:index];
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
#pragma mark - UIScrollViewDelegate
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}

- (CALayer *)lineLayer
{
    if (!_lineLayer) {
        _lineLayer = [[CALayer alloc] init];
        _lineLayer.frame = CGRectMake(0, self.height - 1,KScreenWidth, 0.5);
        _lineLayer.backgroundColor = [UIColor colorWithHexString:@"#E8E8E8"].CGColor;
    }
    return _lineLayer;
}
@end
