//
//  UMengSocialHandler.m
//  BDSprite
//
//  Created by Aufree on 10/15/15.
//  Copyright © 2015 ESTGroup. All rights reserved.
//

#import "UMengSocialHandler.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>

#define USHARE_DEMO_APPKEY @"59c3cc40cae7e759e20002ef"
static NSString* const UMS_Title = @"【友盟+】社会化组件U-Share";
static NSString* const UMS_Prog_Title = @"【友盟+】U-Share小程序";
static NSString* const UMS_Text = @"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！";

static NSString* const UMS_THUMB_IMAGE = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
static NSString* const UMS_IMAGE = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
static NSString* const UMS_WebLink = @"https://bbs.umeng.com/";
static NSString* const UMS_Text_image = @"i欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！";
static NSString* const UMS_Web_Desc = @"W欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！";

static NSString *UMS_SHARE_TBL_CELL = @"UMS_SHARE_TBL_CELL";
@interface UMengSocialHandler ()
@end

@implementation UMengSocialHandler

+ (void)setup {
    [[UMSocialManager defaultManager] openLog:YES];
    // 打开图片水印
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    [UMSocialGlobal shareInstance].isClearCacheWhenGetUserInfo = NO;
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];
    
    [self confitUShareSettings];
    
    [self configUSharePlatforms];
}

+ (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

+ (void)configUSharePlatforms
{
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:nil];
   
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106436648"/*设置QQ平台的appID*/  appSecret:@"KEYDSCSFXJdUq0lEHps" redirectURL:nil];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3002527991"  appSecret:@"369155667ed82bfe4b741cadeef8aa29" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}


+ (void)shareWithShareURL:(NSString *)shareURL
            shareImageUrl:(NSString *)shareImageUrl
               shareTitle:(NSString *)shareTitle
                shareText:(NSString *)shareText
                presentVC:(UIViewController *)vc
                 delegate:(id)delegate {
//    [UMSocialUIManager addCustomPlatformWithoutFilted:UMSocialPlatformType_UserDefine_Begin+2
//                                     withPlatformIcon:[UIImage imageNamed:@"icon_circle"]
//                                     withPlatformName:@"演示icon"];
    
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_None;
#ifdef UM_Swift
    [UMSocialSwiftInterface showShareMenuViewInWindowWithPlatformSelectionBlockWithSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary* userInfo) {
#else
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
#endif
            //在回调里面获得点击的
            if (platformType == UMSocialPlatformType_UserDefine_Begin+2) {
                NSLog(@"点击演示添加Icon后该做的操作");
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"添加自定义icon"
                                                                    message:@"具体操作方法请参考UShareUI内接口文档"
                                                                   delegate:nil
                                                          cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                          otherButtonTitles:nil];
                    [alert show];
                    
                });
            }else if (platformType == UMSocialPlatformType_Sina){
              [self shareImageToPlatformType:platformType viewController:vc];
            }else if (platformType == UMSocialPlatformType_QQ){
                [self shareWebPageToPlatformType:platformType viewController:vc];
            }else
            {
                [self shareImageToPlatformType:platformType viewController:vc];
            }
        }];
}

     //分享图片
+ (void)shareImageToPlatformType:(UMSocialPlatformType)platformType viewController:(UIViewController *)vc
  {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.title = UMS_Title;
    messageObject.text = UMS_Text;
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图本地
    shareObject.thumbImage = [UIImage imageNamed:@"logo"];
    
    [shareObject setShareImage:[UIImage imageNamed:@"logo"]];
    
    // 设置Pinterest参数
    if (platformType == UMSocialPlatformType_Pinterest) {
      [self setPinterstInfo:messageObject];
    }
    
    // 设置Kakao参数
    if (platformType == UMSocialPlatformType_KakaoTalk) {
      messageObject.moreInfo = @{@"permission" : @1}; // @1 = KOStoryPermissionPublic
    }
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
#ifdef UM_Swift
    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:vc completion:^(UMSocialShareResponse * data, NSError * error) {
#else
      //调用分享接口
      [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:vc completion:^(id data, NSError *error) {
#endif
        if (error) {
          UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
          if ([data isKindOfClass:[UMSocialShareResponse class]]) {
            UMSocialShareResponse *resp = data;
            //分享结果消息
            UMSocialLogInfo(@"response message is %@",resp.message);
            //第三方原始返回的数据
            UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            
          }else{
            UMSocialLogInfo(@"response data is %@",data);
          }
        }
//        [self alertWithError:error];
      }];
}
     
     //分享网络图
+ (void)shareImageURLToPlatformType:(UMSocialPlatformType)platformType viewController:(UIViewController *)vc
     {
       //创建分享消息对象
       UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
       
       //创建图片内容对象
       UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
       //如果有缩略图，则设置缩略图
       shareObject.thumbImage = UMS_THUMB_IMAGE;
       
       [shareObject setShareImage:UMS_IMAGE];
       
       // 设置Pinterest参数
       if (platformType == UMSocialPlatformType_Pinterest) {
         [self setPinterstInfo:messageObject];
       }
       
       // 设置Kakao参数
       if (platformType == UMSocialPlatformType_KakaoTalk) {
         messageObject.moreInfo = @{@"permission" : @1}; // @1 = KOStoryPermissionPublic
       }
       
       //分享消息对象设置分享内容对象
       messageObject.shareObject = shareObject;
       
#ifdef UM_Swift
       [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
         //调用分享接口
         [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
#endif
           if (error) {
             UMSocialLogInfo(@"************Share fail with error %@*********",error);
           }else{
             if ([data isKindOfClass:[UMSocialShareResponse class]]) {
               UMSocialShareResponse *resp = data;
               //分享结果消息
               UMSocialLogInfo(@"response message is %@",resp.message);
               //第三方原始返回的数据
               UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
               
             }else{
               UMSocialLogInfo(@"response data is %@",data);
             }
           }
           [self alertWithError:error];
         }];
       }
       
        //网页分享
        + (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType viewController:(UIViewController *)vc
       {
         //创建分享消息对象
         UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
         messageObject.title = @"title";
         messageObject.text = @"text";

         //创建网页内容对象
         NSString* thumbURL =  UMS_THUMB_IMAGE;
         UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:UMS_Title descr:UMS_Web_Desc thumImage:thumbURL];
         //设置网页地址
         shareObject.webpageUrl = UMS_WebLink;
         shareObject.thumbImage = UMS_THUMB_IMAGE;
         //分享消息对象设置分享内容对象
         messageObject.shareObject = shareObject;
         
#ifdef UM_Swift
         [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
           //调用分享接口
           [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:vc completion:^(id data, NSError *error) {
#endif
             if (error) {
               UMSocialLogInfo(@"************Share fail with error %@*********",error);
             }else{
               if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                 UMSocialShareResponse *resp = data;
                 //分享结果消息
                 UMSocialLogInfo(@"response message is %@",resp.message);
                 //第三方原始返回的数据
                 UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                 
               }else{
                 UMSocialLogInfo(@"response data is %@",data);
               }
             }
//             [self alertWithError:error];
           }];
         }

        
          + (void)setPinterstInfo:(UMSocialMessageObject *)messageObj
          {
              messageObj.moreInfo = @{@"source_url": @"http://www.umeng.com",
                                      @"app_name": @"U-Share",
                                      @"suggested_board_name": @"UShareProduce",
                                      @"description": @"U-Share: best social bridge"};
          }
          
          
          + (void)alertWithError:(NSError *)error
          {
              NSString *result = nil;
              if (!error) {
                  result = [NSString stringWithFormat:@"Share succeed"];
              }
              else{
                  NSMutableString *str = [NSMutableString string];
                  if (error.userInfo) {
                      for (NSString *key in error.userInfo) {
                          [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
                      }
                  }
                  if (error) {
                      result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
                  }
                  else{
                      result = [NSString stringWithFormat:@"Share fail"];
                  }
              }
              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                              message:result
                                                             delegate:nil
                                                    cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                                    otherButtonTitles:nil];
              [alert show];
        }
@end
