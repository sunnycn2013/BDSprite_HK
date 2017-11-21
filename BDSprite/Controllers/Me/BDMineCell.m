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

@property (nonatomic,strong)UISwitch * switchOff;
@property (nonatomic,strong)UILabel  * detailLabel;

//@property (nonatomic,strong)UILabel * tagNameLabel;

@end

@implementation BDMineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        [self setUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUI
{
    [self addSubview:self.tagNameLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.switchOff];
    [self addSubview:self.linView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)tapAction:(UITapGestureRecognizer *)ges
{
    if (self.tapBlock) {
        self.tapBlock(self.item, self);
    }
}

- (void)switchChangedAction:(UISwitch *)sender
{
    self.item.type = BDMeItemTypeSwitch;
    self.switchOff.on = (![BDSpriteContext sharedInstance].isDesRed);
    [SVProgressHUD showSuccessWithStatus:@"切换成功"];
    [BDSpriteContext sharedInstance].isDesRed = (![BDSpriteContext sharedInstance].isDesRed);
    [[NSNotificationCenter defaultCenter] postNotificationName:BDGlobalThemeChangedNotification object:nil];
    if (self.tapBlock) {
        self.tapBlock(self.item, self);
    }
}

- (void)fillData:(id)model
{
    if (![model isKindOfClass:[BDMeItemModel class]]) {
        return;
    }
    self.item = (BDMeItemModel *)model;
    self.tagNameLabel.text = self.item.title;
    self.detailLabel.text = self.item.showText;
    [self updateItemStyle:self.item.type];
}

- (void)updateItemStyle:(BDMeItemType)style
{
    if (style == BDMeItemTypeDefault) {
        self.switchOff.hidden = YES;
        self.detailLabel.hidden = YES;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if(style == BDMeItemTypeSwitch){
        self.switchOff.hidden = NO;
        self.detailLabel.hidden = YES;
        self.accessoryType = UITableViewCellAccessoryNone;
    }else if(style == BDMeItemTypeText){
        self.switchOff.hidden = YES;
        self.detailLabel.hidden = NO;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    ///其他
    else if(style == BDMeItemTypeCache){
        self.switchOff.hidden = YES;
        self.detailLabel.hidden = NO;
        self.accessoryType = UITableViewCellAccessoryNone;
    }else if(style == BDMeItemTypeEvaluation){
        self.switchOff.hidden = YES;
        self.detailLabel.hidden = YES;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if(style == BDMeItemTypeAbout){
        self.switchOff.hidden = YES;
        self.detailLabel.hidden = YES;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(style == BDMeItemTypeJoinWeiXin){
        self.switchOff.hidden = YES;
        self.detailLabel.hidden = YES;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(style == BDMeItemTypeHistory){
        self.switchOff.hidden = YES;
        self.detailLabel.hidden = NO;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

- (void)clearText
{
    self.detailLabel.text = @"0.0K";
}

- (void)switchOn:(BOOL)isOn
{
    self.switchOff.on = isOn;
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

- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth - 90, 7, 70, 30)];
        _detailLabel.text = @"V1.0";
        _detailLabel.font = [UIFont systemFontOfSize:15];
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.textAlignment = NSTextAlignmentRight;
    }
    return _detailLabel;
}

- (UISwitch *)switchOff
{
    if (!_switchOff) {
        _switchOff = [[UISwitch alloc] initWithFrame:CGRectMake(KScreenWidth - 70, 7, 150, 30)];
        _switchOff.on = YES;
        [_switchOff addTarget:self action:@selector(switchChangedAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchOff;
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
