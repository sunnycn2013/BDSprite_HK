//
//  BSBottomView.m
//  BDSprite
//
//  Created by ccguo on 2017/9/24.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSBottomView.h"

@interface BSBottomView ()

@property (nonatomic,strong)UIView * lineView;

@end

@implementation BSBottomView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    [self addSubview:self.lineView];
    CGFloat itemWidth = 80;
    CGFloat itemHeight = 44;
    CGFloat space = (SCREEN_WIDTH - 80 *4)/5.0;
    NSArray * images = @[@"share_icon",@"link_icon",@"favorite_icon",@"voted_icon"];
    for (int i = 0; i< 4; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString * image = images[i];
        button.tag = 5000 + i;
        button.frame = CGRectMake(space + (itemWidth + space) * i, 0, itemWidth, itemHeight);
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)itemClicked:(UIButton *)sender
{
    NSInteger index = sender.tag - 5000;
    if ([self.delegate respondsToSelector:@selector(bottomView:didSelectItem:)]) {
        [self.delegate bottomView:self didSelectItem:index];
    }
    DLog(@"%ld",sender.tag);
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
        _lineView.backgroundColor = [UIColor grayColor];
    }
    return _lineView;
}

@end
