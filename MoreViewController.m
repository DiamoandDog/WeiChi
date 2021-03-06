//
//  MoreViewController.m
//  WeiChi
//
//  Created by imac on 15/9/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreTableViewCell.h"
#import "ThemeTableViewController.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"

static NSString *moreCellId = @"moreCellId";
@interface MoreViewController ()
{
   // NSArray *_data;
    UITableView *_tableView;
}
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createTableView];
    
}
//每次出现的时候重新刷新数据
- (void)viewWillAppear:(BOOL)animated{

    [_tableView reloadData];
}

- (void)_createTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_tableView];
    [_tableView registerClass:[MoreTableViewCell class] forCellReuseIdentifier:moreCellId];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCellId forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MoreTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreCellId];
    }
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            cell.themeImageView.imgName = @"more_icon_theme.png";
            cell.themeTextLabel.text = @"主题选择";
            cell.themeDetailLabel.text  = [ThemeManager shareInstance].themeName;
            
        }else if(indexPath.row == 1){
            cell.themeImageView.imgName = @"more_icon_account.png";
            cell.themeTextLabel.text = @"账户管理";
        }
    }else if(indexPath.section == 1){
        cell.themeTextLabel.text=@"意见反馈";
        cell.themeImageView.imgName = @"more_icon_feedback.png";
        
    }else if(indexPath.section ==2){
        cell.themeTextLabel.text = @"登出当前账号";
        cell.themeTextLabel.textAlignment = NSTextAlignmentCenter;
        cell.themeTextLabel.center = cell.contentView.center;
    }
    if(indexPath.section !=2){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    //设置箭头
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //进入主题选择页面
    if(indexPath.row == 0 && indexPath.section == 0){
        ThemeTableViewController *vc = [[ThemeTableViewController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    //登出
    if(indexPath.section==2 && indexPath.row == 0){
        AppDelegate *appDelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        if(appDelegate.sinaweibo.isLoggedIn){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认登出？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            [alert show];
        }else{
            UIAlertView *alert2 = [[UIAlertView alloc]initWithTitle:@"未登入" message:nil delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
            [alert2 show];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate.sinaweibo logOut];
    }

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
