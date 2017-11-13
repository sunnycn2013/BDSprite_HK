//
//  BSPageControl.m
//  BSPageControl
//
//  Created by anxindeli on 16/10/8.
//  Copyright © 2016年 anxindeli. All rights reserved.
//

#import "BSPageControl.h"

@interface BSPageControl ()

@property (nonatomic, strong) NSMutableArray *allItems;
@property (nonatomic,  assign)NSInteger lastPage;            // default is 0. value pinned to

@end

@implementation BSPageControl
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        self.allItems = [NSMutableArray array];
        self.pageIndicatorTintColor = [UIColor colorWithHexString:@"#D9DDE2"];//默认普通状态是红色
        self.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#4979B4"];//选中状态是绿色
    }
    return self;
}

//是否隐藏单个page
- (void)hidenSinglePage
{
    
    if (_hidesForSinglePage && _numberOfPages == 1) {
        self.hidden = true;
    }else{
        self.hidden = false;
    }
}
#pragma mark - setter && getter 方法
- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    _currentPage = 0;
    _lastPage = 0;
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat allWidth = screenWidth - (numberOfPages-1)*20-20;
    CGFloat leftX = allWidth/2.0;
    for (NSInteger i = 0; i<numberOfPages; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.cornerRadius = 5.0f;
        if (i==0) {
            button.backgroundColor = self.currentPageIndicatorTintColor;
        }else{
            button.backgroundColor = self.pageIndicatorTintColor;
        }
        button.tag = i;
        [button addTarget:self action:@selector(doChangePage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.allItems addObject:button];
    }
    
    for (int i =0; i<self.allItems.count; i++)
    {
        UIButton *button1 = self.allItems[i];
        UIButton *button2;
        if (i!=0) {
            button2 = self.allItems[i-1];
        }

        CGFloat marginLeft = (i==0) ? leftX : CGRectGetMaxX(button2.frame) + 10;
        button1.frame = CGRectMake(marginLeft, 5, (i==0?20:10), 10);
    }
    [self hidenSinglePage];
}

- (void)setHidesForSinglePage:(BOOL)hidesForSinglePage
{
    _hidesForSinglePage = hidesForSinglePage;
    [self hidenSinglePage];
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    self.lastPage = _currentPage;
    _currentPage = currentPage;
    [self updatePageControl];
}

- (void)updatePageControl
{
    if (self.currentPage == self.lastPage) {
        return;
    }
    
    if (self.currentPage < self.numberOfPages && self.lastPage < self.numberOfPages) {
        UIButton * currentPoint = self.allItems[self.currentPage];
        UIButton * lastPoint = self.allItems[self.lastPage];

        lastPoint.backgroundColor = self.pageIndicatorTintColor;
        currentPoint.backgroundColor = self.currentPageIndicatorTintColor;
        
        [UIView animateWithDuration:0.25 animations:^{
            lastPoint.frame = CGRectMake(lastPoint.frame.origin.x, lastPoint.frame.origin.y,10, lastPoint.frame.size.height);
            currentPoint.frame = CGRectMake(currentPoint.frame.origin.x, currentPoint.frame.origin.y,20, currentPoint.frame.size.height);
        }];
    }
}
#pragma mark - 点击page调用的方法
- (void)doChangePage:(UIButton *)sender
{
    UIButton *button1 = self.allItems[_currentPage];
    
    if ([button1 isEqual:sender]) {
        return;
    }
    
    button1.backgroundColor = self.pageIndicatorTintColor;
    sender.backgroundColor = self.currentPageIndicatorTintColor;
   
    [UIView animateWithDuration:0.25 animations:^{
        button1.frame = CGRectMake(button1.frame.origin.x, button1.frame.origin.y,10, button1.frame.size.height);
        sender.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y,20, sender.frame.size.height);
    }];
    _currentPage = sender.tag;
}

@end
