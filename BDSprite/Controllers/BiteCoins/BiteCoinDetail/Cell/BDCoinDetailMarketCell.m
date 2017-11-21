//
//  BDCoinDetailMarketCell.m
//  BDSprite
//
//  Created by alibaba on 2017/10/31.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BDCoinDetailMarketCell.h"
#import "BDCoinItemModel.h"

@interface BDCoinDetailMarketCell ()

@property (nonatomic,strong)UIImageView * marketImageView;
@property (nonatomic,strong)UILabel * marketNameLabel;
@property (nonatomic,strong)UILabel * marketVolTagLabel;
@property (nonatomic,strong)UILabel * platformURLLabel;
@property (nonatomic,strong)UILabel * marketVolLabel;
@property (nonatomic,strong)CALayer *lineLayer;

@end

@implementation BDCoinDetailMarketCell
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
    [self addSubview:self.marketImageView];
    [self addSubview:self.marketNameLabel];
    [self addSubview:self.marketVolTagLabel];
    [self addSubview:self.platformURLLabel];
    [self addSubview:self.marketVolLabel];
    [self.layer addSublayer:self.lineLayer];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.lineLayer.frame = CGRectMake(0, self.height-1,KScreenWidth, 0.5);
}

- (void)setDataModel:(BSCoinModel *)dataModel
{
    if (![dataModel isKindOfClass:[BDCoinItemModel class]]) {
        return;
    }
    BDCoinItemModel * model = (BDCoinItemModel *)dataModel;
    _marketNameLabel.text = model.marketSymbol;
    _marketVolTagLabel.text = model.turnvolume;
    _platformURLLabel.text = model.url;
}

- (UIImageView *)marketImageView
{
    if (!_marketImageView) {
        _marketImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 18, 18, 18)];
        _marketImageView.layer.cornerRadius = 9;
        _marketImageView.backgroundColor = [UIColor purpleColor];
    }
    return _marketImageView;
}

- (UILabel *)marketNameLabel
{
    if (!_marketNameLabel) {
        _marketNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_marketImageView.right+3, 10, 120, 18)];
        _marketNameLabel.font = [UIFont systemFontOfSize:12];
        _marketNameLabel.textColor = [UIColor blackColor];
        _marketNameLabel.text = @"Bitfinex";
        _marketNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _marketNameLabel;
}

- (UILabel *)marketVolTagLabel
{
    if (!_marketVolTagLabel) {
        _marketVolTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth - 15 -100, _marketNameLabel.top, 100, 18)];
        _marketVolTagLabel.font = [UIFont systemFontOfSize:12];
        _marketVolTagLabel.textColor = [UIColor blackColor];
        _marketVolTagLabel.text = @"交易量(24H)";
        _marketVolTagLabel.textAlignment = NSTextAlignmentRight;
    }
    return _marketVolTagLabel;
}

- (UILabel *)platformURLLabel
{
    if (!_platformURLLabel) {
        _platformURLLabel = [[UILabel alloc] initWithFrame:CGRectMake(_marketNameLabel.left, _marketNameLabel.bottom+5, 180, 17)];
        _platformURLLabel.font = [UIFont systemFontOfSize:12];
        _platformURLLabel.textColor = [UIColor blackColor];
        _platformURLLabel.text = @"www.baidu.com";
        _platformURLLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _platformURLLabel;
}

- (UILabel *)marketVolLabel
{
    if (!_marketVolLabel) {
        _marketVolLabel = [[UILabel alloc] initWithFrame:CGRectMake(_marketVolTagLabel.left, _platformURLLabel.top, 100, 18)];
        _marketVolLabel.font = [UIFont systemFontOfSize:12];
        _marketVolLabel.textColor = [UIColor blackColor];
        _marketVolLabel.text = @"2，6526.00CNY";
        _marketVolLabel.textAlignment = NSTextAlignmentRight;
    }
    return _marketVolLabel;
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
