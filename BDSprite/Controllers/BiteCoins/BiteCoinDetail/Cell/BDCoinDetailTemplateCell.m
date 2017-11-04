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
@end

@implementation BDCoinDetailTemplateCell
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
    [self addSubview:self.templateTagLabel];
    [self addSubview:self.templateLabel];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
        _templateLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth - 110 , 8, 100, 20)];
        _templateLabel.font = [UIFont boldSystemFontOfSize:18.0];
        _templateLabel.textColor = [UIColor blackColor];
        _templateLabel.text = @"IOTA (IOT)";
    }
    return _templateLabel;
}

@end
