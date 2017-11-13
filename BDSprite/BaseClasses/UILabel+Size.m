//
//  UILabel+Size.m
//  BDSprite
//
//  Created by alibaba on 2017/11/12.
//  Copyright © 2017年 ESTGroup. All rights reserved.
//

#import "UILabel+Size.h"

@implementation UILabel (sizing)

- (CGSize)boundOfSize
{
    CGSize size = [self.text sizeForFont:self.font size:self.size mode:NSLineBreakByWordWrapping];
    return CGSizeMake(size.width+15, size.height+5);
}

@end
