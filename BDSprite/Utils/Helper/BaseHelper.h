//
//  BaseHelper.h
//  BDSprite
//
//  Created by Aufree on 9/22/15.
//  Copyright (c) 2015 ESTGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseHelper : NSObject

+ (NSURL *)qiniuImageCenter:(NSString *)link
                 withWidth:(NSString *)width
                withHeight:(NSString *)height;

+ (NSURL *)qiniuImageCenter:(NSString *)link
                 withWidth:(NSString *)width
                withHeight:(NSString *)height
                      mode:(NSInteger)model;

@end
