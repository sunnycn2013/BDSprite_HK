//
//  BDTopicBnnerCell.m
//  BDSprite
//
//  Created by alibaba on 2017/11/12.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BDTopicBnnerCell.h"
#import <iCarousel/iCarousel.h>

@interface BDTopicBnnerCell()<iCarouselDelegate,iCarouselDataSource>

@property (nonatomic,strong)iCarousel * scrollView;
@property (nonatomic,strong)UIPageControl * pageControl;

@end

@implementation BDTopicBnnerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        [self setUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUI
{
    CGFloat width = KScreenWidth;
    CGFloat height = kIPhone6PScale(194.0);
    _scrollView = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _scrollView.delegate = self;
    _scrollView.dataSource = self;
    _scrollView.pagingEnabled = YES;
    
    _scrollView.type = iCarouselTypeRotary;//iCarouselTypeLinear;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounceDistance = 0.5;
    _scrollView.decelerationRate = 0.5;
    _scrollView.clipsToBounds = YES;
    
    [self addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(150, 100, 70, 20)];
    [_pageControl setCenterX:self.centerX];
    [_pageControl setMj_y:kIPhone6PScale(194) - 25];
    [_pageControl setNumberOfPages:5];
    [_pageControl setCurrentPage:0];
    [self addSubview:_pageControl];
    self.clipsToBounds = YES;
}

- (void)fillData:(id)model
{
//    if (![model isKindOfClass:[CMHomeInfo class]]) {
//        return;
//    }
//    self.bannerModel = (CMHomeInfo *)model;
    [self.scrollView reloadData];
}

- (CGFloat)heightForCellWith:(id)model
{
    return kIPhone6PScale(194);
}
#pragma iCarousel

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
//    return self.bannerModel.bannerList.count;
    return 4;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view
{
    CGFloat width = KScreenWidth;
    CGFloat height = kIPhone6PScale(250);
    UIImageView * reuseView = (UIImageView *)view;
//    CMHomeBanner * banner = [self.bannerModel.bannerList objectAtIndex:index];
    if (!reuseView) {
        reuseView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        reuseView.contentMode = UIViewContentModeScaleAspectFill;
//        [reuseView setImageURL:[NSURL URLWithString:banner.img]];
    }
    return reuseView;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
{
    NSInteger index = _scrollView.scrollOffset;
    
    [_pageControl setCurrentPage:index];
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
//    CMHomeBanner * banner = [self.bannerModel.bannerList objectAtIndex:index];
//    if(self.tapBlock){
//        self.tapBlock(banner.jump);
//    }
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(nullable UIView *)view
{
    CGFloat width = KScreenWidth;
    CGFloat height = kIPhone6PScale(250);
    UIImageView * reuseView = (UIImageView *)view;
//    CMHomeBanner * banner = [self.bannerModel.bannerList objectAtIndex:index];
    if (!reuseView) {
        reuseView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        reuseView.contentMode = UIViewContentModeScaleAspectFill;
//        [reuseView setImageURL:[NSURL URLWithString:banner.img]];
    }
    return reuseView;
}

@end
