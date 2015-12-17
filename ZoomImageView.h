//
//  ZoomImageView.h
//  WeiChi
//
//  Created by imac on 15/9/16.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZoomImageView;
@protocol ZoomImageViewDelegate <NSObject>

@optional
//图片将要放大
-(void)imageWillZoomIn:(ZoomImageView *)imageView;
//图片将缩小
-(void)imageWillZoomOut:(ZoomImageView *)imageView;
//

//

@end

@interface ZoomImageView : UIImageView<NSURLConnectionDataDelegate>

@property(nonatomic,strong)UIImageView *fullImageView;

@property(nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong) NSString *fullImageUrlString;

@property(nonatomic,assign)BOOL isGif;

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,weak)id<ZoomImageViewDelegate> delegate;
@end
