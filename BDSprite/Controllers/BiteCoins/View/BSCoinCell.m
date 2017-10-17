//
//  BSCoinCell.m
//  BDSprite
//
//  Created by alibaba on 2017/9/1.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSCoinCell.h"
#import "BaseView.h"

#import <Masonry/Masonry.h>
#import "UserProfileViewController.h"

static CGFloat topicListCellAvatarHeight = 18;

@interface BSCoinCell ()
@property (nonatomic, strong) UILabel *platformLabel;
@property (nonatomic, strong) UILabel *coinNameLabel;
@property (nonatomic, strong) UILabel *tradingNumLabel;


@property (nonatomic, strong) UILabel *currentPriceLabel;
//@property (nonatomic, strong) UILabel *currentPriceLabel;

@property (nonatomic, strong) UILabel *percentLabel;

@property (nonatomic, assign) BOOL didSetupConstraints;
@end

@implementation BSCoinCell
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
    [self.contentView addSubview:self.platformLabel];
    [self.contentView addSubview:self.coinNameLabel];
    [self.contentView addSubview:self.tradingNumLabel];

    [self.contentView addSubview:self.currentPriceLabel];
    [self.contentView addSubview:self.percentLabel];
    
//    [self.contentView addSubview:self.focuSwitch];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setCoinInfo:(BSCoinModel *)coinInfo
{
    _coinInfo = coinInfo;
    _platformLabel.text = [NSString stringWithFormat:@"%@, %@",_coinInfo.platform,_coinInfo.chinesename];
    _coinNameLabel.text = [NSString stringWithFormat:@"%@ - %@",_coinInfo.chinesename,_coinInfo.englishname];
    _currentPriceLabel.text = [NSString stringWithFormat:@"价格$: %@",_coinInfo.price];
    _percentLabel.text = _coinInfo.percentStr;
//    _tradingNumLabel.text = @"量(24h)6190456.90万";
    _tradingNumLabel.text = [NSString stringWithFormat:@"量(24h)$: %.2f万",_coinInfo.marketValue];

    if ([_coinInfo.percent doubleValue] > 0) {
        _percentLabel.backgroundColor = [UIColor colorWithHexString:@"#CF021B"];
    }else{
        _percentLabel.backgroundColor = [UIColor colorWithHexString:@"#1CAB1A"];
    }
}

- (void)focusBites:(UISwitch *)sender
{
    if(sender.on){
        [SVProgressHUD showInfoWithStatus:@"关注成功"];
    }else
    {
        [SVProgressHUD showInfoWithStatus:@"取消关注"];
    }
}
#pragma mark- set get

- (UILabel *)platformLabel
{
    if (!_platformLabel) {
        _platformLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, kIPhone6PScale(6), kIPhone6PScale(140), kIPhone6PScale(13))];
        _platformLabel.font = [UIFont fontWithName:FontName size:10];
        _platformLabel.text = @"Poloniex, 以太币";
        _platformLabel.textColor = [UIColor lightGrayColor];
    }
    return _platformLabel;
}

- (UILabel *)coinNameLabel {
    if (!_coinNameLabel) {
        _coinNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(13,_platformLabel.bottom + kIPhone6PScale(4), kIPhone6PScale(140), kIPhone6PScale(18))];
        _coinNameLabel.font = [UIFont fontWithName:BoldFontName size:14];
        _coinNameLabel.text = @"BTC/USDT";
    }
    return _coinNameLabel;
}

- (UILabel *)tradingNumLabel
{
    if (!_tradingNumLabel) {
        _tradingNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(13,_coinNameLabel.bottom+ kIPhone6PScale(4), kIPhone6PScale(140), kIPhone6PScale(13))];
        _tradingNumLabel.font = [UIFont fontWithName:FontName size:10];
        _tradingNumLabel.text = @"量(24h)6190456.90万";
        _tradingNumLabel.textColor = [UIColor lightGrayColor];
    }
    return _tradingNumLabel;
}

- (UILabel *)currentPriceLabel
{
    if (!_currentPriceLabel) {
        _currentPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth-95-kIPhone6PScale(81), kIPhone6PScale(18), kIPhone6PScale(81), 25)];
        _currentPriceLabel.font = [UIFont fontWithName:FontName size:12];
        _currentPriceLabel.adjustsFontSizeToFitWidth = YES;
        _currentPriceLabel.textColor = [UIColor blackColor];
        _currentPriceLabel.textAlignment = NSTextAlignmentRight;
        _currentPriceLabel.text = @"4,312";
    }
    return _currentPriceLabel;
}

- (UILabel *)percentLabel
{
    if (!_percentLabel) {
        _percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth-85, kIPhone6PScale(18), kIPhone6PScale(71), 25)];
        _percentLabel.font = [UIFont fontWithName:BoldFontName size:12];
        _percentLabel.adjustsFontSizeToFitWidth = YES;
        _percentLabel.text = @"+0.51%";
        _percentLabel.textAlignment = NSTextAlignmentCenter;
        _percentLabel.textColor = [UIColor whiteColor];
        _percentLabel.layer.cornerRadius = 4.0;
        _percentLabel.layer.masksToBounds = YES;
        _percentLabel.backgroundColor = [UIColor redColor];
    }
    return _percentLabel;
}

#pragma mark Tap User Avatar

- (void)didTapAvatarImageView {
    UserProfileViewController *userProfileVC = [[UIStoryboard storyboardWithName:@"UserProfile"
                                                                          bundle:[NSBundle mainBundle]]
                                                instantiateViewControllerWithIdentifier:@"userprofile"];
    [JumpToOtherVCHandler pushToOtherView:userProfileVC animated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([[gestureRecognizer view] isKindOfClass:[UITableViewCell class]]) {
        return NO;
    }
    return YES;
}

@end
