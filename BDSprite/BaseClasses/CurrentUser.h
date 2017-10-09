//
//  CurrentUser.h
//  BDSprite
//
//  Created by Aufree on 9/30/15.
//  Copyright (c) 2015 ESTGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserEntity.h"
#import "UserModel.h"
#import "UserDBManager.h"

@interface CurrentUser : NSObject

@property (nonatomic, copy) NSNumber *userId;
@property (nonatomic, strong) UserEntity *userInfo;
+ (CurrentUser *)Instance;
- (BOOL)isLogin;
- (BOOL)hasClientToken;
- (void)updateCurrentUserInfoIfNeeded;
- (void)saveUser:(UserEntity *)user;
- (void)setupClientRequestState:(BaseResultBlock)block;
- (void)checkNoticeCount;
- (void)logOut;
- (NSString *)userLabel;
@end
