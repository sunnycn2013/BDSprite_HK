//
//  BDJoninWeixinViewController.m
//  BDSprite
//
//  Created by alibaba on 2017/11/12.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BDJoninWeixinViewController.h"

@interface BDJoninWeixinViewController ()
@property (nonatomic,strong)UILabel * infoLabel;

@property (nonatomic,strong)UIImageView * iconImageView;
@property (nonatomic,strong)UITextView * aboutText;
@end

@implementation BDJoninWeixinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"加入微信群";

    
    _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 70, KScreenWidth - 80, 200)];
    _infoLabel.text = @"诚邀请您加入bite sprite微信群，给我们您的意见和建议，帮助我们改进产品，有志同道合，同舟共进的小伙伴们";
    _infoLabel.textColor = [UIColor lightGrayColor];
    _infoLabel.font = [UIFont systemFontOfSize:16];
    _infoLabel.textAlignment = NSTextAlignmentCenter;
    _infoLabel.numberOfLines = 0;
    [self.view addSubview:_infoLabel];
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(90, 0, KScreenWidth - 180, 210)];
    _iconImageView.image = [UIImage imageNamed:@"about"];
    _iconImageView.centerX = self.view.centerX;
    _iconImageView.top = _infoLabel.bottom + 40;
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_iconImageView setImageURL:[NSURL URLWithString:@"https://icaibei.cn/backupscreen/app/weixin.png"]];
    [self.view addSubview:_iconImageView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
