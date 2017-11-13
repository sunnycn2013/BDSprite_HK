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

@interface BSCoinCell ()

@property (nonatomic, strong) UIView  *noteView;

@property (nonatomic, strong) UILabel *coinNameLabel;
@property (nonatomic, strong) UILabel *coinNameTagLabel;
@property (nonatomic, strong) UILabel *currentPriceLabel;

@property (nonatomic, strong) UILabel *percentLabel;
@property (nonatomic, strong) UILabel *dollorPriceLabel;

@property (nonatomic, strong) CALayer *lineLayer;

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
    [self.contentView addSubview:self.noteView];
    [self.contentView addSubview:self.coinNameLabel];
    [self.contentView addSubview:self.coinNameTagLabel];

    [self.contentView addSubview:self.currentPriceLabel];
    [self.contentView addSubview:self.percentLabel];
    [self.contentView addSubview:self.dollorPriceLabel];

    [self.contentView.layer addSublayer:self.lineLayer];
//    self.contentView.backgroundColor = [UIColor redColor];
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
    CGSize coinNameSize = [self.coinNameLabel boundOfSize];
    self.lineLayer.frame = CGRectMake(0, self.height-1,KScreenWidth, 0.5);
    self.coinNameLabel.width = coinNameSize.width;
    self.coinNameTagLabel.frame = CGRectMake(_coinNameLabel.right+kIPhone6PScale(4),_noteView.top+kIPhone6PScale(7), kIPhone6PScale(33), kIPhone6PScale(12));
}

- (void)setCoinInfo:(BSCoinModel *)coinInfo
{
    if (![coinInfo isKindOfClass:[BSCoinModel class]]) {
        return;
    }
    _coinInfo = coinInfo;
    _coinNameTagLabel.text = [NSString stringWithFormat:@"%@",_coinInfo.englishname];
    _coinNameLabel.text = [NSString stringWithFormat:@"%@ - %@",_coinInfo.chinesename,_coinInfo.englishname];
    _currentPriceLabel.text = [NSString stringWithFormat:@"¥: %@",_coinInfo.price];
    _percentLabel.text = _coinInfo.percentStr;
    _dollorPriceLabel.text = [NSString stringWithFormat:@"$: %.2f万",_coinInfo.marketValue];

    if ([_coinInfo.percent doubleValue] > 0) {
        _percentLabel.textColor = [UIColor colorWithHexString:@"#F55152"];
    }else{
        _percentLabel.textColor = [UIColor colorWithHexString:@"#1CAB1A"];
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
- (UIView *)noteView
{
    if (!_noteView) {
        _noteView = [[UIView alloc] initWithFrame:CGRectMake(14, 10, 4, 45)];
        _noteView.backgroundColor = [UIColor colorWithHexString:@"#F55152"];
    }
    return _noteView;
}

- (UILabel *)coinNameLabel {
    if (!_coinNameLabel) {
        _coinNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_noteView.right+ kIPhone6PScale(4),_noteView.top+kIPhone6PScale(2), kIPhone6PScale(140), kIPhone6PScale(18))];
        _coinNameLabel.font = [UIFont fontWithName:BoldFontName size:14];
        _coinNameLabel.textColor = [UIColor colorWithHexString:@"#212A3D"];
        _coinNameLabel.text = @"BTC/USDT";
    }
    return _coinNameLabel;
}

- (UILabel *)coinNameTagLabel
{
    if (!_coinNameTagLabel) {
        _coinNameTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(_coinNameLabel.right+kIPhone6PScale(4),_noteView.top+kIPhone6PScale(7), kIPhone6PScale(33), kIPhone6PScale(12))];
        _coinNameTagLabel.font = [UIFont fontWithName:FontName size:10];
        _coinNameTagLabel.text = @"Poloniex";
        _coinNameTagLabel.textColor = [UIColor lightGrayColor];
    }
    return _coinNameTagLabel;
}

- (UILabel *)currentPriceLabel
{
    if (!_currentPriceLabel) {
        CGFloat marginLeft = KScreenWidth-15-kIPhone6PScale(120);
        _currentPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(marginLeft, _noteView.top+kIPhone6PScale(5), kIPhone6PScale(120), kIPhone6PScale(18))];
        _currentPriceLabel.font = [UIFont boldSystemFontOfSize:16];
        _currentPriceLabel.adjustsFontSizeToFitWidth = YES;
        _currentPriceLabel.textColor = [UIColor colorWithHexString:@"#4D536C"];
        _currentPriceLabel.textAlignment = NSTextAlignmentRight;
        _currentPriceLabel.text = @"4,312";
    }
    return _currentPriceLabel;
}

- (UILabel *)percentLabel
{
    if (!_percentLabel) {
        _percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_coinNameLabel.left, _noteView.top+kIPhone6PScale(30), kIPhone6PScale(130), kIPhone6PScale(18))];
        _percentLabel.font = [UIFont systemFontOfSize:12];
        _percentLabel.text = @"涨幅  +0.51%";
        _percentLabel.textAlignment = NSTextAlignmentLeft;
        _percentLabel.textColor = [UIColor colorWithHexString:@"#F55152"];
    }
    return _percentLabel;
}

- (UILabel *)dollorPriceLabel
{
    if (!_dollorPriceLabel) {
        _dollorPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_currentPriceLabel.left,_coinNameLabel.bottom+ kIPhone6PScale(11), kIPhone6PScale(120), kIPhone6PScale(13))];
        _dollorPriceLabel.font = [UIFont fontWithName:FontName size:10];
        _dollorPriceLabel.text = @"量(24h)6190456.90万";
        _dollorPriceLabel.textColor = [UIColor lightGrayColor];
        _dollorPriceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _dollorPriceLabel;
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
