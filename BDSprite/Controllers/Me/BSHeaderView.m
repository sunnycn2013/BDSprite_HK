//
//  BSHeaderView.m
//  BDSprite
//
//  Created by ccguo on 2017/10/6.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSHeaderView.h"
#import "WaterView.h"

@interface BSHeaderView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) WaterView *waterView;
@end

@implementation BSHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self setUI];
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setUI{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _imageView.image = [UIImage imageNamed:@"gerenzhuyebeijing"];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_imageView];

//    _waterView = [[WaterView alloc] initWithFrame:CGRectMake(0, self.height - 15, KScreenWidth, 15)];
//    [self addSubview:_waterView];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
