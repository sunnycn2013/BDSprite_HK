//
//  NotificationEntity.h
//  BDSprite
//
//  Created by Aufree on 9/26/15.
//  Copyright (c) 2015 ESTGroup. All rights reserved.
//

#import "BaseEntity.h"
#import "UserEntity.h"

@interface NotificationEntity : BaseEntity
@property (nonatomic, strong) NSNumber *notificationId;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) UserEntity *fromUser;
@property (nonatomic, strong) TopicEntity *topic;
@property (nonatomic, strong) NSDate *createdAt;
@end
