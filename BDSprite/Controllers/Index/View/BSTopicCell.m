//
//  BSTopicCell.m
//  BDSprite
//
//  Created by alibaba on 2017/9/3.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSTopicCell.h"
#import <Masonry/Masonry.h>

@interface BSTopicCell ()

@property (nonatomic, strong) UILabel *topicTitleLabel;
@property (nonatomic, strong) UILabel *topicInfoLabel;
@property (nonatomic, strong) UILabel *topicRepliesCountLabel;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation BSTopicCell
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
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.topicTitleLabel];
    [self.contentView addSubview:self.topicInfoLabel];
//    [self.contentView addSubview:self.topicRepliesCountLabel];
}


- (void)setTopicInfo:(BSTopicInfo *)topicInfo
{
    _topicInfo = topicInfo;
    
//    NSArray * imageURLs = @[@"http://ow00jnv2q.bkt.clouddn.com/distribution_chart.png",
//                            @"http://ow00jnv2q.bkt.clouddn.com/k_line.png",
//                            @"http://ow00jnv2q.bkt.clouddn.com/appstore.png",
//                            @"http://ow00jnv2q.bkt.clouddn.com/coincheck.png",
//                            @"http://ow00jnv2q.bkt.clouddn.com/bitfinex.png",
//                            @"http://ow00jnv2q.bkt.clouddn.com/setting.png",
//                            @"http://ow00jnv2q.bkt.clouddn.com/telegram.png",
//                            @"http://ow00jnv2q.bkt.clouddn.com/jaxx.png",
//                            @"http://ow00jnv2q.bkt.clouddn.com/poloniex.png",
//                            @"http://ow00jnv2q.bkt.clouddn.com/google_authenticator.png",
//                            @"http://ow00jnv2q.bkt.clouddn.com/neo.png",
//                            @"http://ow00jnv2q.bkt.clouddn.com/token_ico_price.png",
//                            @"http://ow00jnv2q.bkt.clouddn.com/imtoken.png",
//                            @"http://ow00jnv2q.bkt.clouddn.com/bittrex.png",
//                            @"http://ow00jnv2q.bkt.clouddn.com/liqui.png",
//                            @"http://ow00jnv2q.bkt.clouddn.com/etherdelta.png"];
//                            //16
    NSInteger index = arc4random() % 15;
    
//    NSURL * imageURL = [NSURL URLWithString:self.topicInfo.imageurl];
//    NSURL * imageURL = [NSURL URLWithString:imageURLs[index]];

//    [_avatarImageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"bd_placeholder.jpg"]];
    NSString * imageName = [NSString stringWithFormat:@"%d",(int)index];
    NSString * imageName2 = [NSString stringWithFormat:@"%@.jpeg",imageName];
    [_avatarImageView setImage:[UIImage imageNamed:imageName2]];
    _topicTitleLabel.text = self.topicInfo.topicTitle;
    _topicInfoLabel.text = [NSString stringWithFormat:@"时间:%@", self.topicInfo.updatimeStr];
    NSNumber *repliesCount = self.topicInfo.topicRepliesCount;
    _topicRepliesCountLabel.text = repliesCount.integerValue > 99 ? @"99+" : repliesCount.stringValue;
    
    if (!_didSetupConstraints) {
        self.didSetupConstraints = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.topicTitleLabel.frame = CGRectMake(13, 10, kIPhone6PScale(240), kIPhone6PScale(84));
    self.topicInfoLabel.frame = CGRectMake(13, _topicTitleLabel.bottom,_topicTitleLabel.width, kIPhone6PScale(17));
    self.avatarImageView.frame = CGRectMake(_topicInfoLabel.right+kIPhone6PScale(13),10, kIPhone6PScale(126), kIPhone6PScale(82));
//    self.topicTitleLabel.backgroundColor = [UIColor redColor];
//    self.topicInfoLabel.backgroundColor = [UIColor purpleColor];
}
#pragma mark - set get

- (UILabel *)topicTitleLabel {
    if (!_topicTitleLabel) {
        _topicTitleLabel = [[UILabel alloc] init];
        _topicTitleLabel.font = [UIFont fontWithName:FontName size:14];
        _topicTitleLabel.numberOfLines = 2;
    }
    return _topicTitleLabel;
}

- (UILabel *)topicInfoLabel {
    if (!_topicInfoLabel) {
        _topicInfoLabel = [[UILabel alloc] init];
        _topicInfoLabel.height = 15;
        _topicInfoLabel.font = [UIFont fontWithName:FontName size:11];
        _topicInfoLabel.numberOfLines = 1;
        _topicInfoLabel.textColor = [UIColor colorWithWhite:0.773 alpha:1.000];
    }
    return _topicInfoLabel;
}

- (UILabel *)topicRepliesCountLabel {
    if (!_topicRepliesCountLabel) {
        _topicRepliesCountLabel = [[UILabel alloc] init];
        _topicRepliesCountLabel.font = [UIFont fontWithName:FontName size:11];
        _topicRepliesCountLabel.numberOfLines = 1;
        _topicRepliesCountLabel.textColor = [UIColor whiteColor];
        _topicRepliesCountLabel.textAlignment = NSTextAlignmentCenter;
        _topicRepliesCountLabel.backgroundColor = [UIColor clearColor];
        _topicRepliesCountLabel.layer.backgroundColor = [UIColor colorWithRed:0.392 green:0.702 blue:0.945 alpha:1.000].CGColor;
    }
    return _topicRepliesCountLabel;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 80)];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.userInteractionEnabled = YES;
        _avatarImageView.clipsToBounds = YES;
    }
    return _avatarImageView;
}

#pragma mark Tap User Avatar
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([[gestureRecognizer view] isKindOfClass:[UITableViewCell class]]) {
        return NO;
    }
    return YES;
}

@end
