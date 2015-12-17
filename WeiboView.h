//
//  WeiboView.h
//  WeiChi
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "WeiboViewLayoutFrame.h"
#import "WXLabel.h"
#import "ZoomImageView.h"
@interface WeiboView : UIView<WXLabelDelegate>

@property(nonatomic,strong)WXLabel *textLabel;

@property(nonatomic,strong)WXLabel *sourceLabel;//转发的微博
@property(nonatomic,strong)ZoomImageView *imgView;
@property(nonatomic,strong)ThemeImageView *bgImageView;//圆微博背景

@property(nonatomic,strong)WeiboViewLayoutFrame *layoutFrame;
@end
