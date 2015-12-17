//
//  WeiboTableView.m
//  WeiChi
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "WeiboTableView.h"
#import "WeiboCell.h"
#import "WeiboModel.h"
#import "DetailViewController.h"
#import "UIView+ViewController.h"
@implementation WeiboTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if(self){
        [self initTable];
    }
    return self;
}

-(void)awakeFromNib{
    [self initTable];
}

- (void)initTable{
    self.delegate = self;
    self.dataSource = self;
    
    //注册单元格
    UINib *nib = [UINib nibWithNibName:@"WeiboCell" bundle:nil];
    
    [self registerNib:nib forCellReuseIdentifier:@"weiboCell"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return _layoutFrameArray.count ;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weiboCell" forIndexPath:indexPath];
    //获得某个cell的布局对象
    WeiboViewLayoutFrame *layoutFrame = _layoutFrameArray[indexPath.row];
    cell.layoutFrame = layoutFrame;
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    WeiboViewLayoutFrame *layoutFrame = _layoutFrameArray[indexPath.row];
    CGFloat height = layoutFrame.frame.size.height;
    
    return height +80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    DetailViewController *vc=[[DetailViewController alloc]init];
    
    WeiboViewLayoutFrame *layoutFrame = _layoutFrameArray[indexPath.row];
    vc.weiboModel = layoutFrame.weiboModel;
    
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
}


@end
