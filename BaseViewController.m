//
//  BaseViewController.m
//  WeiChi
//
//  Created by imac on 15/9/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
@interface BaseViewController (){
    MBProgressHUD *_hud;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor clearColor];
    
   // [self setNavItem];

}
-(void)setNavItem{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setAction)];
    
    
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction)];

}

-(void)setAction{
    MMDrawerController *mmDraw = self.mm_drawerController;
    [mmDraw openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}

-(void)editAction{
    MMDrawerController *mmDraw = self.mm_drawerController;
    [mmDraw openDrawerSide:MMDrawerSideRight animated:YES completion:nil];

}

- (void)showLoading:(BOOL)show{

    if(_tipView == nil){
        _tipView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight/2 - 10, kScreenWidth, 20)];
        _tipView.backgroundColor =[UIColor clearColor];
        
        //创建 activity
        UIActivityIndicatorView *actView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        actView.tag=100;
        [_tipView addSubview:actView];
        
        //label
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.backgroundColor =[UIColor clearColor];
        label.text = @"正在加载";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor =[UIColor blackColor];
        [label sizeToFit];
        
        [_tipView addSubview:label];
        
        label.left = (kScreenWidth-label.width)/2;
        actView.right = label.left - 5;
    }
    
    if(show){
        UIActivityIndicatorView *activityView = [_tipView viewWithTag:100];
        [activityView startAnimating];
        [self.view addSubview:_tipView];
    }else{
    
        if(_tipView.superview){
            UIActivityIndicatorView *activityView = [_tipView viewWithTag:100];
            [activityView stopAnimating];
            [_tipView removeFromSuperview];
        }
    }

}

-(void)showHUD:(NSString *)title{

    if(_hud ==nil){
        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
    }
    [_hud show:YES];
    _hud.labelText = title;
    
    //灰色背景视图覆盖其他视图
    _hud.dimBackground =YES;
}

-(void)hideHUD{
    [_hud hide:YES];
}


-(void)completedHUD:(NSString *)title{

    _hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    _hud.mode = MBProgressHUDModeCustomView;
    
    _hud.labelText = title;
    
    //持续1.5隐藏
    [_hud hide:YES afterDelay:1.5];
    

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
