//
//  BaseViewController.h
//  WeiChi
//
//  Created by imac on 15/9/7.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface BaseViewController : UIViewController
{
    UIView *_tipView;
    
}
-(void)setNavItem;

- (void)showLoading:(BOOL)show;

-(void)showHUD:(NSString *)title;


-(void)hideHUD;

-(void)completedHUD:(NSString *)title;

@end
