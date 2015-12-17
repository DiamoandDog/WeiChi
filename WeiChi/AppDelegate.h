//
//  AppDelegate.h
//  WeiChi
//
//  Created by imac on 15/9/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SinaWeibo.h"
//@class SinaWeibo;
//@class HomeViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,SinaWeiboDelegate>

//@property (strong, nonatomic) UIWindow *window;


@property (strong, nonatomic) SinaWeibo *sinaweibo;
@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) HomeViewController *viewController;
@end

