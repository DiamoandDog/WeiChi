//
//  MainTabBarController.m
//  WeiChi
//
//  Created by imac on 15/9/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavController.h"
#import "ThemeButton.h"
#import "ThemeImageView.h"
#import "AppDelegate.h"
#import "ThemeLabel.h"

@interface MainTabBarController ()
{
    ThemeImageView *_selectedImageView;
    ThemeLabel *_badgeLabel;
    ThemeImageView *_badgeImageView;
}
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _createSubControllers];
    [self _createTabBar];
    
    //开启定时器
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];

}

-(void)timeAction{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [appDelegate.sinaweibo requestWithURL:unread_count
                                   params:nil
                               httpMethod:@"GET"
                                 delegate:self];
    
}

-(void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{

    NSNumber *status = [result objectForKey:@"status"];
    NSInteger count = [status integerValue];
    CGFloat tabBarButtonWidth = kScreenWidth /5;
    if(_badgeImageView == nil){
    
        _badgeImageView = [[ThemeImageView alloc]initWithFrame:CGRectMake(tabBarButtonWidth - 32, 0, 32, 32)];
        _badgeImageView.imgName = @"number_notify_9.png";
        [self.tabBar addSubview:_badgeImageView];
        
        _badgeLabel = [[ThemeLabel alloc]initWithFrame:_badgeImageView.bounds];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.backgroundColor = [UIColor clearColor];
        _badgeLabel.font = [UIFont systemFontOfSize:13];
        _badgeLabel.colorName = @"Timeline_Notice_color";
        [_badgeImageView addSubview:_badgeLabel];
    }
    if(count >0){
        _badgeImageView.hidden = NO;
        if(count > 99){
            count =99;
        
        }
        _badgeLabel.text = [NSString stringWithFormat:@"%li",count];
    }else{
    
        _badgeImageView.hidden = YES;
    }
    
}

- (void)_createTabBar{
    //移除tabBarbutton
    for(UIView *view in self.tabBar.subviews){
    
        Class cls = NSClassFromString(@"UITabBarButton");
        if([view isKindOfClass:cls]){
            [view removeFromSuperview];
        }
    }
    
    //创建imageView作为子视图添加到tabBar
    ThemeImageView *imageView=[[ThemeImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
   // imageView.image=[UIImage imageNamed:@"Skins/cat/mask_navbar.png"];
    [imageView setImgName:@"mask_navbar.png"];
    [self.tabBar addSubview:imageView];
    
    _selectedImageView = [[ThemeImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth / 5, 49)] ;
    //_selectedImageView.image=[UIImage imageNamed:@"Skins/cat/home_bottom_tab_arrow.png"];
    [_selectedImageView setImgName:@"home_bottom_tab_arrow.png"];
    [self.tabBar addSubview:_selectedImageView];
    
    NSArray *imageNames=@[
                          @"home_tab_icon_1.png",
                          @"home_tab_icon_2.png",
                          @"home_tab_icon_3.png",
                          @"home_tab_icon_4.png",
                          @"home_tab_icon_5.png",
                          ];
    
    CGFloat itemWidth=kScreenWidth / imageNames.count;
   
    for(int i=0;i<imageNames.count;i++){
    
        ThemeButton *button=[[ThemeButton alloc]initWithFrame:CGRectMake(i * itemWidth , 0, itemWidth, 49)];
        //[button setImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
        [button setNormalImageName:imageNames[i]];
        button.tag=i;
        [button addTarget:self action:@selector(selectAc:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabBar addSubview:button];
    }


}

- (void)selectAc:(UIButton *)button{
    //NSLog(@"sas");
    [UIView animateWithDuration:0.3 animations:^{
        _selectedImageView.center=button.center;
    }];

    self.selectedIndex = button.tag;
}

- (void)_createSubControllers{
    NSArray *names=@[@"Home",@"Message",@"Profile",@"Discover",@"More"];
    NSMutableArray *navArray=[[NSMutableArray alloc]initWithCapacity:names.count];
    for(int i= 0;i<5;i++){
        NSString *name=names[i];
        
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:name bundle:nil];
        BaseNavController *navVC=[storyBoard instantiateInitialViewController];
        
        [navArray addObject:navVC];
        
    }
    self.viewControllers=navArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
