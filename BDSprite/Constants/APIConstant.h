//
//  APIConstant.h
//  BDSprite
//
//  Created by Aufree on 9/30/15.
//  Copyright (c) 2015 ESTGroup. All rights reserved.
//

#define APIAccessTokenURL [NSString stringWithFormat:@"%@%@", APIBaseURL, @"/oauth/access_token"]
#define QiniuUploadTokenIdentifier @"QiniuUploadTokenIdentifier"

#if DEBUG
#define APIBaseURL      @"https://fengzhihen.com/btcapp/"
#else
#define APIBaseURL      @"https://fengzhihen.com/btcapp/"
#endif

#define BDSpriteHost        @"BDSprite.org"
#define BDSpriteUrl         @"https://BDSprite.org/"
#define GitHubURL         @"https://github.com/"
#define TwitterURL        @"https://twitter.com/"
#define ProjectURL        @"https://github.com/aufree/BDSprite-ios"
#define AboutPageURL      @"http://www.icaibei.com/about/index.html"
#define ESTGroupURL       @"http://est-group.org"
#define AboutTheAuthorURL @"http://www.icaibei.com/about/index.html"
#define BDSpriteGuide       @"http://7xnqwn.com1.z0.glb.clouddn.com/index.html"
#define BDSpriteTopicURL    @"https://BDSprite.org/topics/"
#define SinaRedirectURL   @"http://sns.whalecloud.com/sina2/callback"

#define UpdateNoticeCount @"UpdateNoticeCount"
#define KeyChainService   @"BDSpriteService"
#define KeyChainAccount   @"com.BDSprite.keychain"
