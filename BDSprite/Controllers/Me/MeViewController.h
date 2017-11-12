//
//  MeViewController.h
//  BDSprite
//
//  Created by Aufree on 9/23/15.
//  Copyright (c) 2015 ESTGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDShowInfoViewController.h"
#import "BDAboutViewController.h"
#import "BDJoninWeixinViewController.h"

@interface MeViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userIntroLabel;
@end
