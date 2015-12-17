//
//  ThemeManager.h
//  WeiChi
//
//  Created by imac on 15/9/8.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kThemeDidChangeNotificationName @"kThemeDidChangeNotificationName"
#define kThemeName @"kThemeName"
@interface ThemeManager : NSObject

@property(nonatomic,copy)NSString *themeName;
@property(nonatomic,strong)NSDictionary *themeConfig;//theme.plist的内容
@property(nonatomic,strong)NSDictionary *colorConfig;//每个主题目录下 config.plist内容

+ (ThemeManager *)shareInstance;//单例类方法，获得唯一对象

- (UIImage *)getThemeImage:(NSString *)imageName;

- (UIColor *)getThemeColor:(NSString *)colorName;

@end
