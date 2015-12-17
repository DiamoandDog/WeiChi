//
//  Common.h
//  WeiChi
//
//  Created by imac on 15/9/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#ifndef WeiChi_Common_h
#define WeiChi_Common_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


#define kAppKey             @"3208012042"
#define kAppSecret          @"2dfceec2e6ddf60cbd51216dcba78b9c"
#define kAppRedirectURI     @"https://api.weibo.com/oauth2/default.html"

#define unread_count  @"remind/unread_count.json"  //未读消息
#define home_timeline @"statuses/home_timeline.json"  //微博列表
#define comments      @"comments/show.json"   //评论列表


//微博字体
#define FontSize_weibo(isDetail) isDetail?16:15
#define FontSize_reWeibo(isDetail) isDetail?15:14



#ifndef kAppKey
#error
#endif

#ifndef kAppSecret
#error
#endif

#ifndef kAppRedirectURI
#error
#endif

#endif
