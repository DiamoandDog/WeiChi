//
//  HomeViewController.m
//  WeiChi
//
//  Created by imac on 15/9/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "ThemeManager.h"
#import "WeiboModel.h"
#import "WeiboViewLayoutFrame.h"
#import "MJRefresh.h"
#import "ThemeImageView.h"
#import "ThemeLabel.h"
#import <AudioToolbox/AudioToolbox.h>
@interface HomeViewController ()

@end

@implementation HomeViewController
{

    NSMutableArray *_data;
    ThemeImageView *_barImageView;
    ThemeLabel *_barLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavItem];
    _data = [[NSMutableArray alloc]init];
    
    [self _createTable];
    [self _loadWeiboData];
}

-(void)_createTable{
    _weiboTable = [[WeiboTableView alloc]initWithFrame:self.view.bounds];
    _weiboTable.backgroundColor = [UIColor clearColor];
    //_weiboTable.hidden = YES;
   // _weiboTable.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    [self.view addSubview:_weiboTable];
    
    _weiboTable.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadNewData)];
    _weiboTable.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreData)];


    
}

- (void)_loadWeiboData{

    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //如果已登入，则获取微博数据
    if(appDelegate.sinaweibo.isLoggedIn){
        //[self showLoading:YES];
       [self showHUD:@"余超傻逼"];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        [params setObject:@"10" forKey:@"count"];
        SinaWeiboRequest *request = [appDelegate.sinaweibo requestWithURL:@"statuses/home_timeline.json"
                                        params:params
                                    httpMethod:@"GET"
                                    delegate:self];
        
        request.tag = 100;
        return;
    }
    [appDelegate.sinaweibo logIn];
}

//上啦加载更多
- (void)_loadMoreData{

    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //如果登入则获取微博数据
    if(appDelegate.sinaweibo.isLoggedIn){
        //[self showLoading:YES];
      //  [self showHUD:@"余超傻逼"];

        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        [params setObject:@"10" forKey:@"count"];
        //设置maxId
        if(_data.count != 0){
            WeiboViewLayoutFrame *layoutFrame = [_data lastObject];
            WeiboModel *model = layoutFrame.weiboModel;
            NSString *maxId = model.weiboIdStr;
            [params setObject:maxId forKey:@"max_id"];
        }
        SinaWeiboRequest *request  = [appDelegate.sinaweibo requestWithURL:@"statuses/home_timeline.json" params:params httpMethod:@"GET" delegate:self];
        request.tag = 101;
        return;
    }
    [appDelegate.sinaweibo logIn];
}
//下拉刷新
- (void)_loadNewData{
    
    AppDelegate *appDelegate =  (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (appDelegate.sinaweibo.isLoggedIn) {
        //[self showLoading:YES];
     //   [self showHUD:@"余超傻逼"];

        //params处理
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:@"10" forKey:@"count"];
        //设置 sinceId
        if (_data.count != 0) {
            WeiboViewLayoutFrame *layoutFrame = _data[0];
            WeiboModel *model = layoutFrame.weiboModel;
            NSString *sinceId = model.weiboIdStr;
            [params setObject:sinceId forKey:@"since_id"];
        }
        
        
        SinaWeiboRequest *request = [appDelegate.sinaweibo requestWithURL:@"statuses/home_timeline.json"
                                                                   params:params
                                                               httpMethod:@"GET"
                                                                 delegate:self];
        request.tag = 102;
        
        
        return;
    }
    [appDelegate.sinaweibo logIn];
    

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




- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    //_weiboTable.hidden = NO;
    //NSLog(@"%@",result);
    
    //[self showLoading:NO];
    [self completedHUD:@"余超还是傻逼"];
    //每一条微博存到数组里
    NSArray *dicArray = [result objectForKey:@"statuses"];
    NSMutableArray *layoutFrameArray = [[NSMutableArray alloc]initWithCapacity:dicArray.count];
    
    for(NSDictionary *dataDic in dicArray){
    
        WeiboModel *model = [[WeiboModel alloc]initWithDataDic:dataDic];
        WeiboViewLayoutFrame *layoutFrame = [[WeiboViewLayoutFrame alloc]init];
        layoutFrame.weiboModel = model;
        [layoutFrameArray addObject:layoutFrame];
    }
    if(request.tag == 100){//普通微博
        
        _data = layoutFrameArray;
    }else if(request.tag ==101){
       // [self completedHUD:@"余超还是傻逼"];
        if(layoutFrameArray.count > 1){
            [layoutFrameArray removeObjectAtIndex:0];
            [_data addObjectsFromArray:layoutFrameArray];
        }
    }else if(request.tag ==102){
       // [self completedHUD:@"余超还是傻逼"];
        if(layoutFrameArray.count > 0){
            NSRange range = NSMakeRange(0, layoutFrameArray.count);
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
            [_data insertObjects:layoutFrameArray atIndexes:indexSet];
            
            [self showNewWeiboCount:layoutFrameArray.count];
        }
    }
    if(_data.count != 0){
        _weiboTable.layoutFrameArray = _data;
        [_weiboTable reloadData];
    }
        
    [_weiboTable.header endRefreshing];
    [_weiboTable.footer endRefreshing];
    
}

- (void)showNewWeiboCount:(NSInteger)count{

    if(_barImageView == nil){
        _barImageView = [[ThemeImageView alloc]initWithFrame:CGRectMake(5, -40, kScreenWidth-10, 40)];
        _barImageView.imgName = @"timeline_notify.png";
        [self.view addSubview:_barImageView];
        
        _barLabel = [[ThemeLabel alloc]initWithFrame:_barImageView.bounds];
        _barLabel.colorName = @"Timeline_Notice_color";
        _barLabel.backgroundColor = [UIColor clearColor];
        _barLabel.textAlignment = NSTextAlignmentCenter;
        
        [_barImageView addSubview:_barLabel];
        
    }
    if(count > 0 ){
        _barLabel.text = [NSString stringWithFormat:@"更新了%li条微博",count];
        [UIView animateWithDuration:0.6 animations:^{
            _barImageView.transform = CGAffineTransformMakeTranslation(0, 64+45);
        } completion:^(BOOL finished){
            [UIView animateWithDuration:0.6 animations:^{
                [UIView setAnimationDelay:1];
                _barImageView.transform = CGAffineTransformIdentity;
            }];
        }];
        
        //播放声音
        NSString *path = [[NSBundle mainBundle]pathForResource:@"msgcome" ofType:@"wav"];
        NSURL *url = [NSURL fileURLWithPath:path];
        
        SystemSoundID soundId;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundId);
        AudioServicesPlaySystemSound(soundId);
        
    }
}

@end
















