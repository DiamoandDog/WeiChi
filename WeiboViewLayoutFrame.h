//
//  WeiboViewLayoutFrame.h
//  WeiChi
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboModel.h"
@interface WeiboViewLayoutFrame : NSObject

@property(nonatomic,assign)CGRect textFrame;//微博文字
@property(nonatomic,assign)CGRect srTextFrame;//转发微博文字
@property(nonatomic,assign)CGRect bgImageFrame;//beijing
@property(nonatomic,assign)CGRect imgFrame;//
@property(nonatomic,assign)CGRect frame;//整个weiboView 的frame

@property(nonatomic,strong)WeiboModel *weiboModel;

@property(nonatomic,assign)BOOL isDetail;
@end
