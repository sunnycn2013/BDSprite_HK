//
//  BDTopicBannerCell.m
//  BDSprite
//
//  Created by alibaba on 2017/11/12.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BDTopicBannerCell.h"
#import <iCarousel/iCarousel.h>
#import "BSPageControl.h"
#import <SafariServices/SafariServices.h>

@interface BDTopicBannerCell()<iCarouselDelegate,iCarouselDataSource>

@property (nonatomic,strong)iCarousel * scrollView;
//@property (nonatomic,strong)UIPageControl * pageControl;
@property (nonatomic,strong)BSPageControl * pageControl;

@property (nonatomic,strong)NSArray * dataArrays;

@end

@implementation BDTopicBannerCell

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
    _scrollView = [[iCarousel alloc] initWithFrame:CGRectMake(0, 4, KScreenWidth, kIPhone6PScale(146))];
    _scrollView.delegate = self;
    _scrollView.dataSource = self;
    _scrollView.pagingEnabled = YES;
    
    _scrollView.type = iCarouselTypeRotary;//iCarouselTypeLinear;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounceDistance = 0.5;
    _scrollView.decelerationRate = 0.5;
    _scrollView.clipsToBounds = YES;
    [self addSubview:_scrollView];
    
    _pageControl = [[BSPageControl alloc] initWithFrame:CGRectMake(0, _scrollView.bottom, KScreenWidth, 20)];
    _pageControl.userInteractionEnabled = YES;
    [_pageControl setNumberOfPages:3];
    [_pageControl setCurrentPage:0];
    [self addSubview:_pageControl];
    
    _dataArrays = @[@"https://static.quintar.com/quintar/information/1/1510195143117.png",@"https://static.quintar.com/quintar/information/1/1510286589908.png",@"https://static.quintar.com/quintar/information/1/1510300038538.jpg"];
        self.clipsToBounds = YES;
    [self.scrollView reloadData];
//    self.backgroundColor = [UIColor redColor];
}

- (void)setTopicInfo:(BSTopicInfo *)topicInfo
{
    _topicInfo = topicInfo;
    if ([topicInfo isKindOfClass:[BSTopicInfo class]]) {
        [self.scrollView reloadData];
    }
}

- (CGFloat)heightForCellWith:(id)model
{
    return kIPhone6PScale(194);
}
#pragma iCarousel

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.dataArrays.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view
{
    CGFloat width = kIPhone6PScale(340);
    CGFloat height = kIPhone6PScale(140);
    UIImageView * reuseView = (UIImageView *)view;
    NSString * urlString = [self.dataArrays objectAtIndex:index];
    if (!reuseView) {
        reuseView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        reuseView.contentMode = UIViewContentModeScaleAspectFill;
        reuseView.layer.cornerRadius = 4;
        reuseView.layer.masksToBounds = YES;
        [reuseView setImageURL:[NSURL URLWithString:urlString]];
    }
    [self.pageControl setCurrentPage:index];
    return reuseView;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
{
    NSInteger index = _scrollView.scrollOffset;
    
    [_pageControl setCurrentPage:index];
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(banner:didSelectItemAtIndex:)]) {
        [self.delegate banner:self didSelectItemAtIndex:index];
    }
}

@end
