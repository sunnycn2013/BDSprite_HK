//
//  BSShowMessageViewController.m
//  BDSprite
//
//  Created by ccguo on 2017/9/8.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSShowMessageViewController.h"

@interface BSShowMessageViewController ()

@property (nonatomic,strong)UIButton * submitButton;

@end

@implementation BSShowMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
//    NSString * str = [userDefault valueForKey:BS_Device_Token];
//    NSString * str1 = [userDefault valueForKey:@"aa"];

    UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 64 + 20, SCREEN_WIDTH - 30, 300)];
//    textView.text = [NSString stringWithFormat:@"token: %@ \n  json: %@",str,str1];
    textView.backgroundColor = [UIColor whiteColor];
//    textView.layer.
    [self.view addSubview:textView];
    
    _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitButton.frame = CGRectMake((SCREEN_WIDTH - 150)/2, textView.bottom +30, 150, 40);
    _submitButton.backgroundColor = [UIColor orangeColor];
    _submitButton.layer.cornerRadius = 5;
    [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [_submitButton addTarget:self action:@selector(submitMessage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitButton];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)submitMessage:(UIButton *)sender
{
    [SVProgressHUD showInfoWithStatus:@"发送成功"];
}

@end
