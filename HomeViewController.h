//
//  HomeViewController.h
//  WeiChi
//
//  Created by imac on 15/9/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"
#import "SinaWeiboRequest.h"
#import "WeiboTableView.h"
@interface HomeViewController : BaseViewController<SinaWeiboRequestDelegate>{

    WeiboTableView *_weiboTable;
}


@end
