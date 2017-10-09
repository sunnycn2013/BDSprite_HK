//
//  BSHeaderView.m
//  BDSprite
//
//  Created by ccguo on 2017/10/6.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSHeaderView.h"

@interface BSHeaderView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *iconView;


@end

@implementation BSHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self setUI];
    }
    return self;
}

- (void)setUI{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _imageView.image = [UIImage imageNamed:@"me_head"];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_imageView];
    
    _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    _iconView.image = [UIImage imageNamed:@"icon"];
    _iconView.contentMode = UIViewContentModeScaleAspectFill;
    _iconView.centerX = SCREEN_WIDTH/2;
    _iconView.y = 40;
    [self addSubview:_iconView];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
