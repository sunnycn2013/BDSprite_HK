//
//  TopicDetailViewController.m
//  BDSprite
//
//  Created by Aufree on 10/8/15.
//  Copyright © 2015 ESTGroup. All rights reserved.
//

#import "TopicDetailViewController.h"
#import "BSTopicModel.h"
#import "AccessTokenHandler.h"
#import "UserProfileViewController.h"
#import "TOWebViewController.h"
#import "CommentListViewController.h"
#import "ReplyTopicViewController.h"
#import "TopicVoteView.h"
#import "BaseWebView.h"

//#import "UMSocial.h"
#import "UMengSocialHandler.h"
#import "UIActionSheet+Blocks.h"

@interface TopicDetailViewController () <UIScrollViewDelegate, ReplyTopicViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIView *userInfoView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;
@property (weak, nonatomic) IBOutlet UIButton *voteButton;
@property (weak, nonatomic) IBOutlet BaseWebView *topicContentWeb;
@property (weak, nonatomic) IBOutlet UIView *topicToolBarView;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *linkButton;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarBottomConstraint;
@property (assign, nonatomic) CGPoint pointNow;
@property (assign, nonatomic) CGFloat topicToolBarY;
@property (copy, nonatomic) NSString *topicURL;
@end

@implementation TopicDetailViewController

# pragma mark Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _avatarImageView.layer.cornerRadius = _avatarImageView.height/2;
    _avatarImageView.layer.masksToBounds = YES;
    _topicURL = [NSString stringWithFormat:@"%@%@", BDSpriteTopicURL, _topic.topicId];
    _topicContentWeb.scrollView.delegate = self;
    [self updateTopicDetailView];
    [self fetchTopicDataFromServerWithBlock:nil];
    [self createRightBarButtonItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *logScreen = [NSString stringWithFormat:@"帖子详情 ID:%@", _topic.topicId];
//    [AnalyticsHandler logScreen:logScreen];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _topicToolBarView.hidden = NO;
    _topicToolBarY = _topicToolBarView.y;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    _topicContentWeb.scrollView.delegate = nil;
    _topicContentWeb = nil;
}

# pragma mark Get Data From Server

- (void)fetchTopicDataFromServerWithBlock:(void (^)(NSError *error))completion {
    __weak typeof(self) weakself = self;
    BaseResultBlock callback =^ (NSDictionary *data, NSError *error) {
        if (!error) {
            weakself.topic = data[@"entity"];
            weakself.topicContentWeb.urlString = weakself.topic.topicContentUrl;
            [weakself updateVoteStateWithVoteCount:weakself.topic.voteCount.integerValue];
            [weakself updateTopicDetailView];
            if (completion) completion(error);
        } else {
            [SVProgressHUD showErrorWithStatus:@"未找到该帖子信息"];
            [weakself.navigationController popViewControllerAnimated:YES];
        }
    };
    
//    [[BSTopicModel Instance] getTopicById:_topic.topicId.integerValue callback:callback];
}

# pragma mark More Action

- (void)createRightBarButtonItem {
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"]
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(showActionSheet)];
    rightBarButtonItem.tintColor = [UIColor colorWithRed:0.502 green:0.776 blue:0.200 alpha:1.000];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)showActionSheet {
    [UIActionSheet showInView:self.view
                    withTitle:@"更多操作"
            cancelButtonTitle:@"取消"
       destructiveButtonTitle:nil
            otherButtonTitles:@[@"举报"]
                     tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
                         if (buttonIndex == 0) {
                             // For stupid apple review
                             [SVProgressHUD showSuccessWithStatus:@"举报成功"];
                         }
                     }];
}

- (void)copyTopicUrlToClipboard {
    NSString *topicUrl = _topicURL;
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = topicUrl;
    [SVProgressHUD showSuccessWithStatus:@"复制成功"];
}

- (void)shareToFriends {
    NSString *shareURL = _topicURL;
    NSString *shareImageUrl = _topic.user.avatar;
    NSString *shareTitle = [NSString stringWithFormat:@"分享 %@ 的文章", _topic.user.username];
    NSString *shareText = [NSString stringWithFormat:@"%@ %@", _topic.topicTitle, _topicURL];
    [UMengSocialHandler shareWithShareURL:shareURL shareImageUrl:shareImageUrl shareTitle:shareTitle shareText:shareText presentVC:self delegate:self];
}

# pragma mark Update UI

- (void)updateTopicDetailView {
    UserEntity *user = _topic.user;
    NSURL *url = [BaseHelper qiniuImageCenter:user.avatar withWidth:@"76" withHeight:@"76"];
    [_avatarImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
    _usernameLabel.text = user.username;
    _introductionLabel.text = user.introduction;
    if (_topic.topicRepliesCount.integerValue > 0) {
        NSString *rawRepliesCount = _topic.topicRepliesCount.integerValue > 99 ? @"99+" : _topic.topicRepliesCount.stringValue;
        NSString *repliesCount = [NSString stringWithFormat:@" %@", rawRepliesCount];
        [_commentsButton setTitle:repliesCount forState:UIControlStateNormal];
    }
}

- (void)updateVoteStateWithVoteCount:(NSInteger)voteCount {
    _topic.voteCount = @(voteCount);
    [_voteButton setTitle:[NSString stringWithFormat:@"  %ld", (long)voteCount] forState:UIControlStateNormal];
    
    if (_topic.voteUp && !_topic.voteDown) {
        [_voteButton setImage:[UIImage imageNamed:@"upvote_icon"] forState:UIControlStateNormal];
    } else if (_topic.voteDown && !_topic.voteUp) {
        [_voteButton setImage:[UIImage imageNamed:@"downvote_icon"] forState:UIControlStateNormal];
    } else {
        [_voteButton setImage:[UIImage imageNamed:@"vote_icon"] forState:UIControlStateNormal];
    }
}

# pragma mark Scroll View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < _pointNow.y) {
        [UIView animateWithDuration:0.3 animations:^{
            _toolBarBottomConstraint.constant = 0;
            [_topicToolBarView layoutIfNeeded];
        }];
    } else if (scrollView.contentOffset.y > _pointNow.y) {
        [UIView animateWithDuration:0.3 animations:^{
            _toolBarBottomConstraint.constant = -_topicToolBarView.height;
            [_topicToolBarView layoutIfNeeded];
        }];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _pointNow = scrollView.contentOffset;
}

#pragma mark Touch User Avatar

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == _avatarImageView || [touch view] == _userInfoView) {
        [self jumpToUserProfileVC];
    }
    
}

- (void)jumpToUserProfileVC {
    UserProfileViewController *userProfileVC = [[UIStoryboard storyboardWithName:@"UserProfile"
                                                                          bundle:[NSBundle mainBundle]]
                                                instantiateViewControllerWithIdentifier:@"userprofile"];
    userProfileVC.userEntity = _topic.user;
    [self.navigationController pushViewController:userProfileVC animated:YES];
}

#pragma mark Vote Topic

- (IBAction)didTouchVoteButton:(id)sender {
    [self checkUserPermissionWithAction:^{
        UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
        TopicVoteView *topicVoteView = [[TopicVoteView alloc] initWithFrame:keyWindow.bounds topicEntity:_topic];
        [topicVoteView.upVoteButton addTarget:self action:@selector(upVoteTopic) forControlEvents:UIControlEventTouchUpInside];
        [topicVoteView.downVoteButton addTarget:self action:@selector(downVoteTopic) forControlEvents:UIControlEventTouchUpInside];
        [keyWindow addSubview: topicVoteView];
    }];
}

- (void)upVoteTopic {
    _topic.voteUp = !_topic.voteUp;
    NSInteger voteCount = _topic.voteCount.integerValue;
    if (_topic.voteDown) {
        voteCount += 2;
    } else {
        voteCount = _topic.voteUp ? voteCount + 1 : voteCount - 1;
    }
    _topic.voteDown = NO;
    [self updateVoteStateWithVoteCount:voteCount];
//    [[BSTopicModel Instance] voteUpTopic:_topic.topicId withBlock:nil];
    [self analyticsWithTopicEvent:@"赞帖子"];
}

- (void)downVoteTopic {
    _topic.voteDown = !_topic.voteDown;
    NSInteger voteCount = _topic.voteCount.integerValue;
    if (_topic.voteUp) {
        voteCount -= 2;
    } else {
        voteCount = !_topic.voteDown ? voteCount + 1 : voteCount - 1;
    }
    _topic.voteUp = NO;
    [self updateVoteStateWithVoteCount:voteCount];
//    [[BSTopicModel Instance] voteDownTopic:_topic.topicId withBlock:nil];
    [self analyticsWithTopicEvent:@"踩帖子"];
}

# pragma mark Topic Action

- (IBAction)didTouchShareButton:(id)sender {
    [self shareToFriends];
}

- (IBAction)didTouchLinkButton:(id)sender {
    [self copyTopicUrlToClipboard];
}

- (IBAction)didTouchReplyButton:(id)sender {
    [self checkUserPermissionWithAction:^{
        ReplyTopicViewController *replyTopicVC = [[UIStoryboard storyboardWithName:@"Topic" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"replyTopic"];
        replyTopicVC.topicId = _topic.topicId;
        replyTopicVC.delegate = self;
        [self.navigationController pushViewController:replyTopicVC animated:YES];
    }];
}

- (IBAction)didTouchCommentsButton:(id)sender {
    [self jumpToCommentsView];
}

- (void)jumpToCommentsView {
    if (_topic.topicRepliesUrl) {
        CommentListViewController *commentsListVC = [[CommentListViewController alloc] init];
        commentsListVC.topic = _topic;
        [self.navigationController pushViewController:commentsListVC animated:YES];
        [self analyticsWithTopicEvent:@"查看帖子评论"];
    }
}

# pragma mark Check User Permission

- (void)checkUserPermissionWithAction:(void (^)(void))completion {
    if ([[CurrentUser Instance] isLogin]) {
        if (completion) completion();
    } else {
        __weak typeof(self) weakself = self;
        [JumpToOtherVCHandler jumpToLoginVC:^{
            [weakself fetchTopicDataFromServerWithBlock:^(NSError *error) {
                if (error) return;
                if (completion) completion();
            }];
        }];
    }
}


# pragma mark Google Analytics

- (void)analyticsWithTopicEvent:(NSString *)event {
}
@end
