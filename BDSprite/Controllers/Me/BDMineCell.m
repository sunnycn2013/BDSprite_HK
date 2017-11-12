//
//  BDMineCell.m
//  BDSprite
//
//  Created by ccguo on 2017/11/5.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BDMineCell.h"
#import "BDMeGroupModel.h"

@interface BDMineCell ()

@property (nonatomic,strong)UILabel * tagNameLabel;
@property (nonatomic,strong)BDMeItemModel * item;
@property (nonatomic,strong)UIView * linView;

//@property (nonatomic,strong)UILabel * tagNameLabel;

@end

@implementation BDMineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        [self setUI];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUI
{
    [self addSubview:self.tagNameLabel];
    [self addSubview:self.linView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillData:(id)model
{
    if (![model isKindOfClass:[BDMeItemModel class]]) {
        return;
    }
    self.item = (BDMeItemModel *)model;
    self.tagNameLabel.text = self.item.title;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.linView.y = self.height - 2;
}

- (UILabel *)tagNameLabel
{
    if (!_tagNameLabel) {
        _tagNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 150, 30)];
        _tagNameLabel.text = @"关于我们";
        _tagNameLabel.font = [UIFont systemFontOfSize:15];
        _tagNameLabel.textColor = [UIColor grayColor];
    }
    return _tagNameLabel;
}

- (UIView *)linView
{
    if (!_linView) {
        _linView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 2)];
        _linView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    }
    return _linView;
}
@end
