//
//  RightViewController.m
//  WeiChi
//
//  Created by imac on 15/9/9.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "RightViewController.h"
#import "ThemeButton.h"
#import "SendViewController.h"
#import "ThemeManager.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "BaseNavController.h"

@interface RightViewController ()
{
    NSArray *_array;
}
@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBgImage];
    self.view.backgroundColor = [UIColor clearColor];
    
    [self _createButton];
}


-(void)_createButton{
    _array = @[@"newbar_icon_1.png",@"newbar_icon_2.png",@"newbar_icon_3.png",@"newbar_icon_4.png",@"newbar_icon_5.png"];
   // CGFloat height = (kScreenHeight -300)/5;
    for (int i=1;i<=5;i++){
        ThemeButton *button = [[ThemeButton alloc]initWithFrame: CGRectMake(20, 20+50*(i-1), 40, 40)];
        [button setNormalImageName:_array[i-1]];
        //NSString *imageName = [NSString stringWithFormat:@"newbar_icon_%d.png",i];
        
        button.tag=i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

-(void)buttonAction:(UIButton *)button{

    if (button.tag == 1) {
        // 发送微博
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
            // 弹出发送微博控制器
            
            SendViewController *senderVc = [[SendViewController alloc] init];
            senderVc.title = @"发送微博";
            
            
            // 创建导航控制器
            BaseNavController *baseNav = [[BaseNavController alloc] initWithRootViewController:senderVc];
            [self.mm_drawerController presentViewController:baseNav animated:YES completion:nil];
        }];
    }
    
    
}

- (void)setBgImage{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_loadImage) name:kThemeDidChangeNotificationName object:nil];
    
    [self _loadImage];
}

- (void)_loadImage{
    
    ThemeManager *manager = [ThemeManager shareInstance];
    UIImage *img = [manager getThemeImage:@"bg_home.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:img];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
