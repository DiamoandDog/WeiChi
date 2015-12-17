//
//  ThemeManager.m
//  WeiChi
//
//  Created by imac on 15/9/8.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ThemeManager.h"

@implementation ThemeManager

+ (ThemeManager *)shareInstance{

    static ThemeManager *instance = nil;
    static dispatch_once_t token;
    dispatch_once(&token,^{
    
        instance = [[[self class] alloc]init];
    });
    return instance;
}
- (instancetype)init{
    self=[super init];
    if(self){
        
        //读取本地持久化存储的主题名字
       _themeName = [[NSUserDefaults standardUserDefaults] objectForKey:kThemeName];
        if(_themeName.length==0){
            //默认
            _themeName=@"Cat";
            
        }
        //读取主题名  主题路径 配置文件，放到字典里
        NSString *path=[[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        
        _themeConfig=[NSDictionary dictionaryWithContentsOfFile:path];
        
        //读取颜色配置
        NSString *themePath = [self themePath];
        NSString *filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        _colorConfig=[NSDictionary dictionaryWithContentsOfFile:filePath];
        
    }
    return self;
}
//主题切换，设置主题名字，触发通知

-(void)setThemeName:(NSString *)themeName{
    if(![_themeName isEqualToString:themeName]){
        _themeName=[themeName copy];
        
        //吧主题名字存储到plist
        [[NSUserDefaults standardUserDefaults] setObject:_themeName forKey:kThemeName];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        //重新读取颜色配置文件
        NSString *themePath = [self themePath];
        NSString *filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        self.colorConfig=[NSDictionary dictionaryWithContentsOfFile:filePath];
        
        //发送通知
        [[NSNotificationCenter defaultCenter]postNotificationName:kThemeDidChangeNotificationName object:nil];
        
    }
    
}

- (UIColor *)getThemeColor:(NSString *)colorName{

    if(colorName.length==0){
    
        return nil;
    }
    NSDictionary *rgbDic = [_colorConfig objectForKey:colorName];
    CGFloat r = [rgbDic[@"R"]floatValue];
    CGFloat g = [rgbDic[@"G"]floatValue];
    CGFloat b = [rgbDic[@"B"]floatValue];
    CGFloat alpha = 1;
    
    if(rgbDic[@"alpha"]!=nil){
        alpha=[rgbDic[@"alpha"]floatValue];
        alpha=alpha/255.0;
    }
    UIColor *color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
    return color;
}

-(UIImage *)getThemeImage:(NSString *)imageName{
    NSString *themePath=[self themePath];
    NSString *filePath=[themePath stringByAppendingPathComponent:imageName];
    
    UIImage *image=[UIImage imageWithContentsOfFile:filePath];
    
    return image;

}

- (NSString *)themePath{
    NSString *bundlePath=[[NSBundle mainBundle]resourcePath];
    
    NSString *themePath=[self.themeConfig objectForKey:self.themeName];
    
    NSString *path=[bundlePath stringByAppendingPathComponent:themePath];
    
    return path;
}
@end
