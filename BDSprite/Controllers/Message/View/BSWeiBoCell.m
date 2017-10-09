//
//  BSWeiBoCell.m
//  BDSprite
//
//  Created by alibaba on 2017/9/1.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSWeiBoCell.h"

@interface BSWeiBoCell ()

@property (nonatomic,strong)UIImageView * avatorImageView;
@property (nonatomic,strong)UILabel * authorLabel;
@property (nonatomic,strong)UILabel * weiBoTitleLabel;
@property (nonatomic,strong)UILabel * sendTimeLabel;
//@property (nonatomic,strong)UILabel * fromDeviceLabel;
//@property (nonatomic,strong)UILabel * weiBoDesLabel;

@end

@implementation BSWeiBoCell

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
    [self.contentView addSubview:self.avatorImageView];
    [self.contentView addSubview:self.authorLabel];
    [self.contentView addSubview:self.weiBoTitleLabel];
    [self.contentView addSubview:self.sendTimeLabel];
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
    self.avatorImageView.frame = CGRectMake(10, 8, kIPhone6PScale(53), kIPhone6PScale(53));
    self.authorLabel.frame = CGRectMake(_avatorImageView.right+5, 10, kIPhone6PScale(285), kIPhone6PScale(25));
    self.weiBoTitleLabel.frame = CGRectMake(_authorLabel.left, _authorLabel.bottom, kIPhone6PScale(285), kIPhone6PScale(21));
    self.sendTimeLabel.frame = CGRectMake(_weiBoTitleLabel.right+kIPhone6PScale(10), 14, kIPhone6PScale(43), kIPhone6PScale(18));
}

- (void)setWeibo:(BSWeiBoModel *)weibo
{
    _weibo = weibo;
    [self.avatorImageView setImageURL:[NSURL URLWithString:_weibo.imageurl]];
    self.authorLabel.text = weibo.wbname;
    self.weiBoTitleLabel.text = weibo.text;
    self.sendTimeLabel.text = weibo.updateTimeStr;
}

#pragma mark - set get
- (UIImageView *)avatorImageView
{
    if (!_avatorImageView) {
        _avatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, kIPhone6PScale(53), kIPhone6PScale(53))];
        _avatorImageView.layer.cornerRadius = kIPhone6PScale(53)/2;
        _avatorImageView.layer.masksToBounds = YES;
        _avatorImageView.image = [UIImage imageNamed:@"anonymous_logo"];
    }
    return _avatorImageView;
}

- (UILabel *)authorLabel
{
    if (!_authorLabel) {
        _authorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _authorLabel.font = [UIFont boldSystemFontOfSize:14];
        _authorLabel.text = @"比特币战车";
        _authorLabel.textColor = [UIColor blackColor];
    }
    return _authorLabel;
}

- (UILabel *)weiBoTitleLabel
{
    if (!_weiBoTitleLabel) {
        CGFloat width = KScreenWidth - kIPhone6PScale(80+10);
        _weiBoTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_avatorImageView.right +5 , 5,width , kIPhone6PScale(25))];
        _weiBoTitleLabel.font = [UIFont systemFontOfSize:12];
        _weiBoTitleLabel.textColor = [UIColor lightGrayColor];
    }
    return _weiBoTitleLabel;
}

//- (UILabel *)weiBoDesLabel
//{
//    if (!_weiBoDesLabel) {
//        CGFloat width = KScreenWidth - kIPhone6PScale(80+10);
//        _weiBoDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(_weiBoTitleLabel.left,_weiBoTitleLabel.bottom + 5, width, kIPhone6PScale(50))];
//        _weiBoDesLabel.font = [UIFont systemFontOfSize:12];
//        _weiBoDesLabel.numberOfLines = 0;
//        _weiBoDesLabel.text = @"【最新分享】或因募资主体出现问题，币安已取消PAMA项目";
////        _weiBoDesLabel.backgroundColor = [UIColor purpleColor];
//    }
//    return _weiBoDesLabel;
//}

//- (YYLabel *)weiBoDesLabel
//{
//    if (!_weiBoDesLabel) {
//        CGFloat width = KScreenWidth - kIPhone6PScale(80+10);
//        _weiBoDesLabel = [[YYLabel alloc] initWithFrame:CGRectMake(_weiBoTitleLabel.left,_weiBoTitleLabel.bottom + 5, width, kIPhone6PScale(50))];
//        _weiBoDesLabel.font = [UIFont systemFontOfSize:12];
//        _weiBoDesLabel.numberOfLines = 0;
//        _weiBoDesLabel.text = @"【最新分享】或因募资主体出现问题，币安已取消PAMA项目";
////        _weiBoDesLabel.backgroundColor = [UIColor yellowColor];
//    }
//    return _weiBoDesLabel;
//}

//- (UIWebView *)weiBoDesLabel
//{
//    if (!_weiBoDesLabel) {
//        CGFloat width = KScreenWidth - kIPhone6PScale(80+10);
//        _weiBoDesLabel = [[UIWebView alloc] initWithFrame:CGRectMake(_weiBoTitleLabel.left,_weiBoTitleLabel.bottom + 5, width, kIPhone6PScale(50))];
//        _weiBoDesLabel.scalesPageToFit = YES;
////        _weiBoDesLabel.font = [UIFont systemFontOfSize:12];
////        _weiBoDesLabel.numberOfLines = 0;
////        _weiBoDesLabel.text = @"【最新分享】或因募资主体出现问题，币安已取消PAMA项目";
//        //        _weiBoDesLabel.backgroundColor = [UIColor yellowColor];
//    }
//    return _weiBoDesLabel;
//}



- (UILabel *)sendTimeLabel
{
    if (!_sendTimeLabel) {
        _sendTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_authorLabel.right, _authorLabel.top, kIPhone6PScale(130), kIPhone6PScale(20))];
        _sendTimeLabel.font = [UIFont systemFontOfSize:8];
        _sendTimeLabel.text = @"2018-9-1 13:00";
        _sendTimeLabel.textColor = [UIColor lightGrayColor];
        _sendTimeLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _sendTimeLabel;
}

//- (UILabel *)fromDeviceLabel
//{
//    if (!_fromDeviceLabel) {
//        CGFloat x = KScreenWidth - kIPhone6PScale(100+10);
//        _fromDeviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, _sendTimeLabel.top, kIPhone6PScale(100), kIPhone6PScale(20))];
//        _fromDeviceLabel.font = [UIFont systemFontOfSize:8];
//        _fromDeviceLabel.text = @"全新引擎iPhone 7 Plus";
//        _fromDeviceLabel.textColor = [UIColor lightGrayColor];
//    }
//    return _fromDeviceLabel;
//}
@end
