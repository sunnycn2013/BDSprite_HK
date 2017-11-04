//
//  BDCoinHeadView.m
//  BDSprite
//
//  Created by alibaba on 2017/11/2.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BDCoinHeadView.h"

@interface BDCoinHeadView()

@property (nonatomic,strong)UILabel * nameLabel;

@end

@implementation BDCoinHeadView

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
    [self addSubview:self.nameLabel];
    self.backgroundColor = [UIColor lightGrayColor];
}

- (void)fillTitle:(NSString *)title
{
    _nameLabel.text = title;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 16)];
        _nameLabel.font = [UIFont boldSystemFontOfSize:14];
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.text = @"综合信息";
    }
    return _nameLabel;
}
@end
