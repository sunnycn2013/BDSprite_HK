//
//  UMengSocialHandler.h
//  BDSprite
//
//  Created by Aufree on 10/15/15.
//  Copyright © 2015 ESTGroup. All rights reserved.
//

//#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
//#import "UMSocialSinaHandler.h"

@interface UMengSocialHandler : NSObject
+ (void)setup;
+ (void)shareWithShareURL:(NSString *)shareURL
            shareImageUrl:(NSString *)shareImageUrl
               shareTitle:(NSString *)shareTitle
                shareText:(NSString *)shareText
                presentVC:(UIViewController *)vc
                 delegate:(id)delegate;
@end
