//
//  WeiboTableView.h
//  WeiChi
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboViewLayoutFrame.h"
@interface WeiboTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray *layoutFrameArray;

@end
