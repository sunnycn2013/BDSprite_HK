//
//  UserProfileViewController.m
//  BDSprite
//
//  Created by Aufree on 10/2/15.
//  Copyright © 2015 ESTGroup. All rights reserved.
//

#import "UserProfileViewController.h"
#import "TOWebViewController.h"
#import "TopicListViewController.h"
#import "EditUserProfileViewController.h"
#import "CommentListViewController.h"
#import "UIActionSheet+Blocks.h"

@interface UserProfileViewController () <EditUserProfileViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *realnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userIntroLabel;
@property (weak, nonatomic) IBOutlet UILabel *localLabel;
@property (weak, nonatomic) IBOutlet UILabel *githubLabel;
@property (weak, nonatomic) IBOutlet UILabel *twitterLabel;
@property (weak, nonatomic) IBOutlet UILabel *blogLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _avatarImageView.layer.cornerRadius = _avatarImageView.height/2;
    _avatarImageView.layer.masksToBounds = YES;
    
    NSNumber *currentUserId = [CurrentUser Instance].userId;
    BOOL isCurrentUser = _userEntity.userId.integerValue == currentUserId.integerValue;
    [self createRightButtonItemWithCurrentUser:isCurrentUser];
    if (currentUserId && isCurrentUser) {
        _userEntity = [[CurrentUser Instance] userInfo];
        [self updateUserProfileView];
//        [AnalyticsHandler logScreen:@"我的资料页面"];
    } else {
        [self fetchUserData];
//        [AnalyticsHandler logScreen:[NSString stringWithFormat:@"他人资料页面 ID:%@", _userEntity.userId]];
    }
}

- (void)fetchUserData {
    __weak typeof(self) weakself = self;
    BaseResultBlock callback =^ (NSDictionary *data, NSError *error) {
        if (!error) {
            _userEntity = data[@"entity"];
            [weakself updateUserProfileView];
        }
    };
    
    [[UserModel Instance] getUserById:_userEntity.userId callback:callback];
}

- (void)updateUserProfileView {
    NSString *avatarHeight = [NSString stringWithFormat:@"%.f", _avatarImageView.height * 2];
    NSURL *URL = [BaseHelper qiniuImageCenter:_userEntity.avatar withWidth:avatarHeight withHeight:avatarHeight];
    [_avatarImageView sd_setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
    _usernameLabel.text = _userEntity.username;
    _realnameLabel.text = [self stringFormatter:_userEntity.realName];
    _userIntroLabel.text = [self stringFormatter:_userEntity.introduction];
    _localLabel.text = [self stringFormatter:_userEntity.city];
    _githubLabel.text = [self stringFormatter:_userEntity.githubName];
    _twitterLabel.text = [self stringFormatter:_userEntity.twitterAccount];
    _blogLabel.text = [self stringFormatter:_userEntity.blogURL];
    _createdAtLabel.text = [NSString stringWithFormat:@"%@", _userEntity.createdAtDate];
}

- (NSString *)stringFormatter:(NSString *)string {
    if ([NSString isStringEmpty:string]) {
        return @"无";
    } else {
        return string;
    }
}

- (void)refreshUserProfileView {
    _userEntity = [[CurrentUser Instance] userInfo];
    [self updateUserProfileView];
}

- (void)createRightButtonItemWithCurrentUser:(BOOL)isCurrentUser {
    UIImage *buttonImage;
    SEL buttonAction;
    if (isCurrentUser) {
        buttonImage = [UIImage imageNamed:@"edit_profile_icon"];
        buttonAction = @selector(jumpToEditUserProfile);
    } else {
        buttonImage = [UIImage imageNamed:@"more"];
        buttonAction = @selector(showActionSheet);
    }
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:buttonImage
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:buttonAction];
    rightBarButtonItem.tintColor = [UIColor colorWithRed:0.502 green:0.776 blue:0.200 alpha:1.000];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)jumpToEditUserProfile {
    EditUserProfileViewController *editUserProfileVC = [[UIStoryboard storyboardWithName:@"UserProfile"
                                                                                  bundle:[NSBundle mainBundle]]
                                                        instantiateViewControllerWithIdentifier:@"edituserprofile"];
    editUserProfileVC.delegate = self;
    [self.navigationController pushViewController:editUserProfileVC animated:YES];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSString *urlString;
    UIViewController *vc;
    
    if (section == 3 && row == 0 && ![NSString isStringEmpty:_userEntity.githubName]) {
        // Jump to GitHub
        urlString = [NSString stringWithFormat:@"%@%@", GitHubURL, _userEntity.githubName];
    } else if (section == 4 && row == 0 && ![NSString isStringEmpty:_userEntity.twitterAccount]) {
        // Jump to Twitter
        urlString = [NSString stringWithFormat:@"%@%@", TwitterURL, _userEntity.twitterAccount];
    } else if (section == 5 && row == 0) {
        // Jump to Blog
        urlString = _userEntity.blogURL;
    } else if (section == 6) {
        switch (row) {
            case 0:
                vc = [self createTopicListWithType:TopicListTypeNormal];
                break;
            case 1:
                [self jumpToCommentListView];
                break;
            case 2:
                vc = [self createTopicListWithType:TopicListTypeVoted];
                break;
                
            default:
                break;
        }
    }
    
    if (![NSString isStringEmpty:urlString]) {
        vc = [[TOWebViewController alloc] initWithURLString:urlString];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    
    if (section < 3 || section > 6) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

- (TopicListViewController *)createTopicListWithType:(TopicListType)topicListType {
    TopicListViewController *topicListVC = [[TopicListViewController alloc] init];
    topicListVC.userId = _userEntity.userId.integerValue;
    topicListVC.topicListType = topicListType;
    return topicListVC;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (void)jumpToCommentListView {
    CommentListViewController *commentListVC = [[CommentListViewController alloc] init];
    TopicEntity *topic = [TopicEntity new];
    topic.topicRepliesUrl = _userEntity.repliesUrl;
    commentListVC.topic = topic;
    [self.navigationController pushViewController:commentListVC animated:YES];
}
@end
