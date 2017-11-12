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
@property (nonatomic, strong) UILabel     *nickNameLabel;
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
    
    _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 86, 72, 72)];
    _iconView.image = [UIImage imageNamed:@"headImage"];
    _iconView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_iconView];
    
    _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconView.right + 10, _iconView.top + 7, 150, 35)];
    _nickNameLabel.text = @"你好, Sprite";
    _nickNameLabel.font = [UIFont boldSystemFontOfSize:16];
    _nickNameLabel.textColor = [UIColor whiteColor];
    [self addSubview:_nickNameLabel];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
