//
//  BSMessageCell.m
//  BDSprite
//
//  Created by ccguo on 2017/12/7.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSMessageCell.h"

@interface BSMessageCell ()

@property (nonatomic,strong)UIImageView * avatorImageView;
@property (nonatomic,strong)UILabel * authorLabel;
@property (nonatomic,strong)UILabel * weiBoTitleLabel;
@property (nonatomic,strong)UILabel * sendTimeLabel;

@end

@implementation BSMessageCell

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
    self.contentView.clipsToBounds = YES;
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
    CGFloat height = 0.0;
    CGFloat width = KScreenWidth - kIPhone6PScale(10);
    CGSize size = [_weibo.text sizeForFont:[UIFont systemFontOfSize:12] size:CGSizeMake(width, 200) mode:NSLineBreakByWordWrapping];
    height = size.height;
    if (height > 300) {
        height = 300;
    }
    
    height = (height < 70) ? 70:height;

    self.avatorImageView.frame = CGRectMake(10, 8, kIPhone6PScale(20), kIPhone6PScale(20));
    self.authorLabel.frame = CGRectMake(_avatorImageView.right+5, 10, kIPhone6PScale(285), kIPhone6PScale(25));
    self.weiBoTitleLabel.frame = CGRectMake(_authorLabel.left, _authorLabel.bottom, width,height-50);
    self.sendTimeLabel.frame = CGRectMake(_weiBoTitleLabel.right+kIPhone6PScale(10), 14, kIPhone6PScale(43), kIPhone6PScale(18));
}

- (void)setWeibo:(BSWeiBoModel *)weibo
{
    _weibo = weibo;
    [self.avatorImageView setImageURL:[NSURL URLWithString:_weibo.imageurl]];
    self.authorLabel.text = weibo.wbname;
    self.sendTimeLabel.text = weibo.updateTimeStr;

    if (weibo.text.length > 0) {
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithData:[weibo.text dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:2.0];
        [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attrStr length])];
        
        self.weiBoTitleLabel.attributedText = attrStr;
        [self.weiBoTitleLabel sizeToFit];
    }

}

+ (CGFloat)calculateCellHeightWithModel:(BSWeiBoModel *)model
{
    CGFloat height = 0.0;
    CGFloat width = KScreenWidth - kIPhone6PScale(10);
    CGSize size = [model.text sizeForFont:[UIFont systemFontOfSize:12] size:CGSizeMake(width, 200) mode:NSLineBreakByWordWrapping];
    height = size.height;
    if (height > 300) {
        height = 300;
    }
    
    return (height < 70) ? 70:height;
}

#pragma mark - set get
- (UIImageView *)avatorImageView
{
    if (!_avatorImageView) {
        _avatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, kIPhone6PScale(20), kIPhone6PScale(20))];
        _avatorImageView.layer.cornerRadius = kIPhone6PScale(20)/2;
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
        CGFloat width = KScreenWidth - kIPhone6PScale(10);
        _weiBoTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_avatorImageView.right +5 , 5,width , kIPhone6PScale(25))];
        _weiBoTitleLabel.font = [UIFont systemFontOfSize:12];
        _weiBoTitleLabel.textColor = [UIColor lightGrayColor];
        _weiBoTitleLabel.numberOfLines = 0;
    }
    return _weiBoTitleLabel;
}

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
@end
