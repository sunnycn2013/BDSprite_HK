//
//  BSSettingCell.m
//  BDSprite
//
//  Created by alibaba on 2017/9/28.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "BSSettingCell.h"

@interface BSSettingCell ()

@property (nonatomic,strong) UISwitch * notiSwitch;

@end

@implementation BSSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.notiSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 65, 5, 100, 38)];
    self.notiSwitch.on = YES;
    [self.notiSwitch addTarget:self action:@selector(notiSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.notiSwitch];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)notiSwitch:(id)sender {
    if (self.notiSwitch.on) {
        [SVProgressHUD showInfoWithStatus:@"打开推送"];
    }else{
        [SVProgressHUD showInfoWithStatus:@"关闭推送"];
    }
}
@end
