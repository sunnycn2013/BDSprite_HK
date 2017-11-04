//
//  BDCoinDetailHeaderCell.m
//  BDSprite
//
//  Created by alibaba on 2017/10/31.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BDCoinDetailHeaderCell.h"

@interface BDCoinDetailHeaderCell ()

@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UILabel * priceLabel;
@property (nonatomic,strong)UILabel * percentLabel;

@end

@implementation BDCoinDetailHeaderCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    [self addSubview:self.nameLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.percentLabel];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 6, 200, 30)];
        _nameLabel.font = [UIFont boldSystemFontOfSize:18.0];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.text = @"IOTA (IOT)";
    }
    return _nameLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, _nameLabel.bottom+6, 340, 30)];
        _priceLabel.font = [UIFont boldSystemFontOfSize:30.0];
        _priceLabel.textColor = [UIColor blackColor];
        _priceLabel.text = @"¥ 2，6526.00CNY";
    }
    return _priceLabel;
}

- (UILabel *)percentLabel
{
    if (!_percentLabel) {
        _percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, _priceLabel.bottom+10, 140, 17)];
        _percentLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _percentLabel.textColor = [UIColor greenColor];
        _percentLabel.text = @"- 2.38% (今日)";
    }
    return _percentLabel;
}
@end
