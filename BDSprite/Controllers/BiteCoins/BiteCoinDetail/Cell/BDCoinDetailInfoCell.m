//
//  BDCoinDetailInfoCell.m
//  BDSprite
//
//  Created by alibaba on 2017/10/31.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BDCoinDetailInfoCell.h"

@interface BDCoinDetailInfoCell()

@property (nonatomic,strong)UILabel * infoLabel;
@property (nonatomic,strong)CALayer *lineLayer;

@end

@implementation BDCoinDetailInfoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUI
{
    [self addSubview:self.infoLabel];
    [self.layer addSublayer:self.lineLayer];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.infoLabel.height = self.height;
    CGSize size = [_infoLabel.text sizeForFont:_infoLabel.font size:CGSizeMake(KScreenWidth- 30,100) mode:NSLineBreakByWordWrapping];
    _infoLabel.height = size.height;
    self.lineLayer.frame = CGRectMake(0, self.height-1,KScreenWidth, 0.5);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataModel:(BSCoinModel *)dataModel
{
    if (![dataModel isKindOfClass:[BSCoinModel class]]) {
        return;
    }
    _infoLabel.text = dataModel.infoBean.descriptionInfo;
}

- (UILabel *)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, KScreenWidth- 30, 30)];
        _infoLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _infoLabel.textColor = [UIColor grayColor];
        _infoLabel.numberOfLines = 0;
        _infoLabel.textAlignment = NSTextAlignmentJustified;
        _infoLabel.text = @"是少数派的一个全新栏目。它面向完全「零基础」的新手用户，通过最简单易懂的方式，帮助你快速掌握关于系统和软硬件的入门知识";
    }
    return _infoLabel;
}

- (CALayer *)lineLayer
{
    if (!_lineLayer) {
        _lineLayer = [[CALayer alloc] init];
        _lineLayer.frame = CGRectMake(0, self.height-1,KScreenWidth, 0.5);
        _lineLayer.backgroundColor = [UIColor colorWithHexString:@"#E8E8E8"].CGColor;
    }
    return _lineLayer;
}

@end
