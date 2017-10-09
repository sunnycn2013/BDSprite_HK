//
//  NSString+Additions.m
//  BDSprite
//
//  Created by Aufree on 10/1/15.
//  Copyright © 2015 ESTGroup. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)
+ (BOOL)isStringEmpty:(NSString *)string {
    if([string length] == 0) { //string is empty or nil
        return YES;
    }
    
    if(![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        //string is all whitespace
        return YES;
    }
    
    return NO;
}

+ (NSNumber *)covertToNumber:(NSString *)numberString {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    return [formatter numberFromString:numberString];
}
@end
