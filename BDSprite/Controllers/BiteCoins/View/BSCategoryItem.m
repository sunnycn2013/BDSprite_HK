//
//  BSCategoryItem.m
//  BDSprite
//
//  Created by alibaba on 2017/10/11.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSCategoryItem.h"

@implementation BSCategoryItem

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
    [self addSubview:self.bgButton];
    [self addSubview:self.indicatorView];
    [self setStyle:BSCategoryItemStyleNormal];
}

- (void)setTitle:(NSString *)title
{
    [_bgButton setTitle:title forState:UIControlStateNormal];
    [_bgButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

- (void)setStyle:(BSCategoryItemStyle)style
{
    if (style == BSCategoryItemStyleSelected) {
        [UIView animateWithDuration:0.2 animations:^{
            self.indicatorView.backgroundColor = [UIColor blueColor];
        }];
    }else if (style == BSCategoryItemStyleNormal){
        [UIView animateWithDuration:0.2 animations:^{
            self.indicatorView.backgroundColor = [UIColor clearColor];
        }];
    }
}

- (void)buttonClicked:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(categoryItem:didSelected:)]) {
        [self.delegate categoryItem:self didSelected:nil];
    }
}
#pragma mark -  set get
- (UIButton *)bgButton
{
    if (!_bgButton)
    {
        CGFloat  width = 60;
        CGFloat  height = 44;
        _bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgButton.frame = CGRectMake(0, 0, width, height);
        _bgButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _bgButton.userInteractionEnabled = YES;
        [_bgButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_bgButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgButton;
}

- (UIView *)indicatorView
{
    if (!_indicatorView) {
        CGFloat  width = 60;
        _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 41, width, 3)];
        _indicatorView.backgroundColor = [UIColor blueColor];
    }
    return _indicatorView;
}

@end
