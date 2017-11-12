//
//  MeViewController.m
//  BDSprite
//
//  Created by Aufree on 9/23/15.
//  Copyright (c) 2015 ESTGroup. All rights reserved.
//

#import "MeViewController.h"
#import "BSLocalPageViewController.h"
#import "LoginViewController.h"
#import "UserProfileViewController.h"
#import "TopicListViewController.h"
#import "SettingsViewController.h"
#import "CommentListViewController.h"
#import "TOWebViewController.h"
#import "BSHeaderView.h"
#import "BDMineCell.h"
#import "BDMeModel.h"
#import "BDMeGroupModel.h"

//#527ACB
@interface MeViewController () <LoginViewControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UserEntity *userEntity;
@property (nonatomic, strong) BSHeaderView *headerView;

@property (weak, nonatomic) IBOutlet UILabel *unreadCountLabel;
@property (strong, nonatomic) BDMeModel * floors;

@end

@implementation MeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    self.floors = [[BDMeModel alloc] init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [self.tableView registerClass:[BDMineCell class] forCellReuseIdentifier:@"BDMineCell"];
    
    self.navigationController.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([[CurrentUser Instance] isLogin]) {
        [self updateMeView];
        [self setupUnreadCountLabel];
    } else
    {
    }
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)setupCornerRadiusWithView:(NSArray *)views {
    for (UIView *view in views) {
        view.layer.cornerRadius = view.height/2;
        view.layer.masksToBounds = YES;
    }
}

- (void)setupUnreadCountLabel {
    if (self.navigationController.tabBarItem.badgeValue.integerValue > 0) {
        _unreadCountLabel.hidden = NO;
        _unreadCountLabel.text = self.navigationController.tabBarItem.badgeValue;
    }
}

- (void)updateUnreadCount:(NSNotification *)notification {
    NSNumber *unreadCount = notification.userInfo[@"unreadCount"];
    if (unreadCount.integerValue > 0) {
        _unreadCountLabel.hidden = NO;
        _unreadCountLabel.text = unreadCount.stringValue;
    } else {
        _unreadCountLabel.hidden = YES;
    }
}

- (void)updateMeView {
    self.userEntity = [CurrentUser Instance].userInfo;
    
    if (_userEntity) {
        NSString *avatarHeight = [NSString stringWithFormat:@"%.f", _avatarImageView.height * 2];
        NSURL *URL = [BaseHelper qiniuImageCenter:_userEntity.avatar withWidth:avatarHeight withHeight:avatarHeight];
        [_avatarImageView sd_setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"avatar_placeholder"]];
        _usernameLabel.text = _userEntity.username;
        _userIntroLabel.text = [NSString isStringEmpty:_userEntity.introduction] ? @"个人签名为空哦 :)" : _userEntity.introduction;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.floors.items count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BDMeGroupModel * group = [self.floors.items objectAtIndex:section];
    return group.sections.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDMeGroupModel * group = [self.floors.items objectAtIndex:indexPath.section];
    BDMeItemModel * item = [group.sections objectAtIndex:indexPath.row];
    BDMineCell * cell = (BDMineCell *)[tableView dequeueReusableCellWithIdentifier:@"BDMineCell"];
    [cell fillData:item];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    BDMeGroupModel * group = [self.floors.items objectAtIndex:section];
    return group.headHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        BSHeaderView * header = [[BSHeaderView alloc] initWithFrame:CGRectMake(0, 200, KScreenWidth, 200)];
        return header;
    }
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 30)];
    view.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    UIViewController *vc;
    if (section == 0 && row == 0) {

    } else if (section == 1) {
        switch (row) {
            case 0: {
                BSLocalPageViewController *notificationListVC = [[BSLocalPageViewController alloc] initWithStyle:BSLocalPageTypeHistory];
                vc = notificationListVC;
                break;
            } case 1: {
                vc = [[BSLocalPageViewController alloc] initWithStyle:BSLocalPageTypeFavourite];
                break;
            }
        }
    } else if (section == 2) {
        if (row == 0) {
            vc = [self createTopicListWithType:TopicListTypeNormal];
        } else if (row == 1) {
             vc = [[UIStoryboard storyboardWithName:@"Settings" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"settings"];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (vc) {
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UINavigationControllerDelegate
    // 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (TopicListViewController *)createTopicListWithType:(TopicListType)topicListType
 {
    TopicListViewController *topicListVC = [[TopicListViewController alloc] init];
    topicListVC.userId = [[CurrentUser Instance] userId].integerValue;
    topicListVC.topicListType = topicListType;
    return topicListVC;
}

- (void)jumpToCommentListView {
    CommentListViewController *commentListVC = [[CommentListViewController alloc] init];
    commentListVC.hidesBottomBarWhenPushed = YES;
    TopicEntity *topic = [TopicEntity new];
    topic.topicRepliesUrl = _userEntity.repliesUrl;
    commentListVC.topic = topic;
    [self.navigationController pushViewController:commentListVC animated:YES];
}

@end
