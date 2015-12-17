//
//  BaseNavController.m
//  WeiChi
//
//  Created by imac on 15/9/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseNavController.h"
#import "ThemeManager.h"
@interface BaseNavController ()

@end

@implementation BaseNavController

-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self= [super initWithCoder:aDecoder];
    if(self){
        //注册通知监听
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeChange:) name:kThemeDidChangeNotificationName object:nil];
    }
    return self;
    
    
}

-(void)themeChange:(NSNotification *)notification{
    [self loadImage];
}

- (void)loadImage{

    //修改导航栏背景
    ThemeManager *manager=[ThemeManager shareInstance];
    UIImage *image=[manager getThemeImage:@"mask_titlebar64.png"];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    //修改主题文字颜色
    UIColor *color = [manager getThemeColor:@"Mask_Title_color"];
    NSDictionary *attrDic = @{NSForegroundColorAttributeName:color};
    
    self.navigationBar.titleTextAttributes =attrDic;
    self.navigationBar.tintColor = color;
    
    //
    UIImage *bgImage=[manager getThemeImage:@"bg_home.jpg"];
    [bgImage stretchableImageWithLeftCapWidth:50 topCapHeight:0];
    self.view.backgroundColor=[UIColor colorWithPatternImage:bgImage];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
