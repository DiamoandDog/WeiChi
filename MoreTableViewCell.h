//
//  MoreTableViewCell.h
//  WeiChi
//
//  Created by imac on 15/9/10.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeManager.h"
#import "ThemeLabel.h"
#import "ThemeImageView.h"
@interface MoreTableViewCell : UITableViewCell

@property(nonatomic,strong)ThemeImageView *themeImageView;
@property(nonatomic,strong)ThemeLabel *themeTextLabel;
@property(nonatomic,strong)ThemeLabel *themeDetailLabel;

@end
































