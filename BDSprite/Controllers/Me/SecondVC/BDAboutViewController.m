//
//  BDAboutViewController.m
//  BDSprite
//
//  Created by alibaba on 2017/11/12.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BDAboutViewController.h"

@interface BDAboutViewController ()

@property (nonatomic,strong)UIImageView * iconImageView;
@property (nonatomic,strong)UITextView * aboutText;

@end

@implementation BDAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关于我们";
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 110, 100)];
    _iconImageView.image = [UIImage imageNamed:@"about"];
    _iconImageView.centerX = self.view.centerX;
    _iconImageView.top = 100;
    [self.view addSubview:_iconImageView];
    
    
    _aboutText = [[UITextView alloc] initWithFrame:CGRectMake(20, _iconImageView.bottom +100, KScreenWidth - 40, 400)];
    _aboutText.text = @"  ------------------ 币动精灵 -------------------   ---------实时币信息、涨跌一手信息在握.---------         --- 多种数字货币市值、涨跌幅排名查询---            --------------各种新币价格及交易市场查询,国内外多个交易市场价格对比---------      ----------实时微博twiter 消息推送早知道---------";
    _aboutText.editable = NO;
    _aboutText.textColor = [UIColor lightGrayColor];
    _aboutText.font = [UIFont systemFontOfSize:16];
    _aboutText.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_aboutText];

    // Do any additional setup after loading the view.
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
