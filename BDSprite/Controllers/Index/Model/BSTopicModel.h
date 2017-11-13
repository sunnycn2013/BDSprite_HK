//
//  BSTopicModel.h
//  BDSprite
//
//  Created by Aufree on 9/22/15.
//  Copyright (c) 2015 ESTGroup. All rights reserved.
//

#import "TopicApi.h"

@interface BSTopicInfo : NSObject

@property (nonatomic, strong) NSNumber *topicId;
@property (nonatomic, strong) NSNumber *categoryId;
@property (nonatomic, copy) NSString *topicTitle;
@property (nonatomic, copy) NSString *topicBody;
@property (nonatomic, strong) NSNumber *topicRepliesCount;
@property (nonatomic, strong) NSNumber *voteCount;
@property (nonatomic, strong) UserEntity *user;
@property (nonatomic, strong) UserEntity *lastReplyUser;
@property (nonatomic, strong) CategoryEntity *category;
@property (nonatomic, copy) NSString *topicContentUrl;
@property (nonatomic, copy) NSString *topicRepliesUrl;
@property (nonatomic, assign) BOOL voteUp;
@property (nonatomic, assign) BOOL voteDown;
@property (nonatomic, copy) NSString *abstracts;
@property (nonatomic, copy) NSString *imageurl;
@property (nonatomic, strong) NSDate *updatedAt;
@property (nonatomic, strong) NSString *updatimeStr;

@property (nonatomic, strong) NSArray *banners;

@end

@interface BSTopicModel : NSObject

- (instancetype)initWithParams:(id)params;

@property (nonatomic, strong) NSMutableArray *data;

@end

