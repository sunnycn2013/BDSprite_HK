//
//  BDMessageDetailViewController.m
//  BDSprite
//
//  Created by alibaba on 2017/10/30.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BDMessageDetailViewController.h"

@interface BDMessageDetailViewController ()
@property (nonatomic,strong)NSDictionary * params;
@property (nonatomic,strong)UIWebView    * webView;

@end

@implementation BDMessageDetailViewController
- (instancetype)initWithParams:(NSDictionary *)params
{
    self = [super init];
    if (self) {
        self.params = params;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString * htmlString = self.params[@"text"];
    NSString * title = self.params[@"title"];
    NSString * url = self.params[@"url"];

    self.title = title;
    [self.webView loadHTMLString:htmlString baseURL:nil];
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
    }
    return _webView;
}
@end
