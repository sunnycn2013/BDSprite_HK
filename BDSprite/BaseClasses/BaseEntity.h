//
//  BaseEntity.h
//  BDSprite
//
//  Created by Aufree on 9/21/15.
//  Copyright (c) 2015 ESTGroup. All rights reserved.
//

//#import "MTLModel.h"
//#import "MTLJSONAdapter.h"
//#import "MTLValueTransformer.h"
//#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
//#import "MTLFMDBAdapter.h"

@interface BaseEntity : NSObject
#pragma mark - Class Methods to create Entity

+ (NSDateFormatter *)dateFormatter;

+ (id)entityFromDictionary:(NSDictionary *)data;
+ (NSArray *)arrayOfEntitiesFromArray:(NSArray *)array;

#pragma mark - Instance Method

- (NSDictionary *)transformToDictionary;
+ (NSArray *)transformToArray:(NSArray *)array;
@end
