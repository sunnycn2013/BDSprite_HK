//
//  BDCoinDetailTemplateCell.m
//  BDSprite
//
//  Created by alibaba on 2017/10/31.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BDCoinDetailTemplateCell.h"

@interface BDCoinDetailTemplateCell ()

@property (nonatomic,strong)UILabel * templateTagLabel;
@property (nonatomic,strong)UILabel * templateLabel;
@property (nonatomic,strong)CALayer *lineLayer;

@end

@implementation BDCoinDetailTemplateCell
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
    [self addSubview:self.templateTagLabel];
    [self addSubview:self.templateLabel];
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

- (void)setDataModel:(BSCoinModel *)dataModel
{
    if (![dataModel isKindOfClass:[BSCoinModel class]]) {
        return;
    }
    if ([self.patton isEqualToString:BDCoinFloorRank]) {
        _templateTagLabel.text = @"排名";
        _templateLabel.text = [NSString stringWithFormat:@"%@",dataModel.rank];
    }else if ([self.patton isEqualToString:BDCoinFloorVol]){
        _templateTagLabel.text = @"市值";
        _templateLabel.text = [NSString stringWithFormat:@"¥ %@",dataModel.infoBean.total_num];
    }else if ([self.patton isEqualToString:BDCoinFloorCirculation]){
        _templateTagLabel.text = @"流通量";
        _templateLabel.text = [NSString stringWithFormat:@"%@ XRP",dataModel.infoBean.cur_num];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.lineLayer.frame = CGRectMake(0, self.height-1,KScreenWidth, 0.5);
}

- (UILabel *)templateTagLabel
{
    if (!_templateTagLabel) {
        _templateTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 8, 200, 20)];
        _templateTagLabel.font = [UIFont boldSystemFontOfSize:18.0];
        _templateTagLabel.textColor = [UIColor blackColor];
        _templateTagLabel.text = @"市值";
    }
    return _templateTagLabel;
}

- (UILabel *)templateLabel
{
    if (!_templateLabel) {
        _templateLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth - 170 , 8, 160, 20)];
        _templateLabel.font = [UIFont boldSystemFontOfSize:18.0];
        _templateLabel.textColor = [UIColor blackColor];
        _templateLabel.text = @"IOTA (IOT)";
        _templateLabel.adjustsFontSizeToFitWidth = YES;
        _templateLabel.textAlignment = NSTextAlignmentRight;
    }
    return _templateLabel;
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
