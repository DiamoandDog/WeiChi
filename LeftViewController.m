//
//  LeftViewController.m
//  WeiChi
//
//  Created by imac on 15/9/9.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()
{

    UITableView *_tableView;
    NSArray *_array;
}
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createTableView];
    
    _array = @[@"无",@"偏移",@"偏移&缩放",@"旋转",@"视差",@"小图",@"大图"];


}
-(void)_createTableView{

    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.rowHeight = 40;
    //_tableView.sectionHeaderHeight = 50;
    
    
    
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        return 5;
    }else{
    
        return 2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if(indexPath.section == 0){
        cell.textLabel.text = _array[indexPath.row];
    }else{
        cell.textLabel.text =_array[indexPath.row + 5];
        
    }
    return cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSArray *_data=@[@"界面切换效果",@"图片浏览模式"];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 40)];
    
    
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor lightGrayColor];
    if (section == 0) {
        label.text = [NSString stringWithFormat:@"%@",_data[0]];
    }
    else {
    label.text = [NSString stringWithFormat:@"%@",_data[1]];
        
    }
    return label;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
