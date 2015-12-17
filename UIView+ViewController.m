//
//  UIView+ViewController.m
//  WeiChi
//
//  Created by imac on 15/9/15.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)

-(UIViewController *)viewController{

    //
    UIResponder *next = self.nextResponder;
    
    do{
    
        //判断响应者类型是否是视图控制器
        
        if([next isKindOfClass:[UIViewController class]]){
        
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    }while (next != nil);
        return nil;
    
}
@end
