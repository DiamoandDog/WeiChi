//
//  ZoomImageView.m
//  WeiChi
//
//  Created by imac on 15/9/16.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ZoomImageView.h"
#import "MBProgressHUD.h"
#import "UIImage+GIF.h"
@implementation ZoomImageView{
    NSURLConnection *_connection;
    double _length;
    NSMutableData *_data;
    MBProgressHUD *_hud;
}

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if(self){
        [self _initTap];
        [self _createGif];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if(self){
        [self _initTap];
        [self _createGif];
    }
    return self;
}
-(instancetype)initWithImage:(UIImage *)image{

    self = [super initWithImage:image];
    if(self){
        [self _initTap];
        [self _createGif];
    }
    return self;
}
-(void)_initTap{

    //打开交互
    self.userInteractionEnabled = YES;
    //创建单击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomIn)];
    [self addGestureRecognizer:tap];
    
    //imageView 图片显示模式 保持比例
    self.contentMode = UIViewContentModeScaleAspectFit;
}


-(void)_createGif{
    //判断gif
    
        _iconView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _iconView.hidden=YES;
        _iconView.image = [UIImage imageNamed:@"timeline_gif.png"];
        [self addSubview:_iconView];
        

}

-(void)zoomIn{
    
    if([self.delegate respondsToSelector:@selector(imageWillZoomIn:)]){
    
        [self.delegate imageWillZoomIn:self];
    }

    self.hidden = YES;
    //创建大图浏览的_scrollView
    [self _createView];
    //计算_fullImageView的frame
    //把自己相对于父视图的frame 转换成相对于window的frame
    CGRect frame = [self convertRect:self.bounds toView:self.window];
    _fullImageView.frame = frame;
    
    //添加动画 放大
    [UIView animateWithDuration:0.3  animations:^{
        _fullImageView.frame=_scrollView.frame;
    } completion:^(BOOL finished){
        _fullImageView.backgroundColor = [UIColor blackColor];
        [self _downLoadImage];
    }];
}



-(void)_downLoadImage{
    //请求网络 下载原图片
    if(self.fullImageUrlString.length > 0){
        //进度显示
        if(_hud == nil){
            _hud = [MBProgressHUD showHUDAddedTo:_scrollView animated:YES];
        }
        _hud.mode = MBProgressHUDModeDeterminate;
        _hud.progress = 0.0;
        NSURL *url = [NSURL URLWithString:_fullImageUrlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
        _connection = [NSURLConnection connectionWithRequest:request delegate:self];
    }
    
}

-(void)zoomOut{
    
    
    if([self.delegate respondsToSelector:@selector(imageWillZoomOut:)]){
        
        [self.delegate imageWillZoomOut:self];
    }
    
    //取消网络下载
    [_connection cancel];

    self.hidden = NO;
    _fullImageView.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = [self convertRect:self.bounds toView:self.window];
        _fullImageView.frame = frame;
        //如果scroll内容已经便宜，则偏移量也得计算
        _fullImageView.top += _scrollView.contentOffset.y;
    } completion:^(BOOL finished){
        [_scrollView removeFromSuperview];
        _scrollView = nil;
        _fullImageView = nil;
        _hud = nil;
        
    }];
}
-(void)_createView{
    if(_scrollView == nil){
        //创建scrollView添加到window
        _scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self.window addSubview:_scrollView];
        //创建大图 fullImageView
        _fullImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
        _fullImageView.image = self.image;
        [_scrollView addSubview:_fullImageView];
        
        //添加缩小手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomOut)];
        [_scrollView addGestureRecognizer:tap];
        
        //长按 保存
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(savePhoto:)];
        [_scrollView addGestureRecognizer:longPress];
        

        
    }
}

-(void)savePhoto:(UILongPressGestureRecognizer *)longPress{
    //
    if(longPress.state == UIGestureRecognizerStateBegan){
    
        //淡出提示框
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否保存图片" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if(buttonIndex == 1){
        UIImage *img = _fullImageView.image;
        //将大图片保存到相册
        UIImageWriteToSavedPhotosAlbum(img,self,@selector(image:didFinishSavingWithError:contextInfo:),nil);
    }
}

//保存成功调用
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{

    //提示保存成
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    //显示模式改为：自定义视图模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"保存成功";
    
    //延迟隐藏
    [hud hide:YES afterDelay:1.5];
}

#pragma mark - 网络下载
//服务器响应请求
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{

    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    //1 取得响应头
    NSDictionary *headerFields = [httpResponse allHeaderFields];
    //2 获取文件大小
    NSString *lengthStr = [headerFields objectForKey:@"Content-Length"];
    _length = [lengthStr doubleValue];
    
    _data = [[NSMutableData alloc]init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_data appendData:data];
    CGFloat progress = _data.length/_length;
    _hud.progress =progress;

}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection{

    [_hud hide:YES];
    UIImage *image = [UIImage imageWithData:_data];
    _fullImageView.image = image;
    
    //尺寸处理
    CGFloat length = image.size.height/image.size.width * kScreenWidth;
    if(length > kScreenHeight){
        [UIView animateWithDuration:0.3 animations:^{
        
            _fullImageView.height = length;
            _scrollView.contentSize = CGSizeMake(kScreenWidth, length);
        }];
    }
    [self gifImageShow];
}

-(void)gifImageShow{
//    //
//    UIWebView *webView = [[UIWebView alloc]initWithFrame:_scrollView.bounds];
//    
//    webView.userInteractionEnabled = NO;
//    webView.scalesPageToFit= YES;
//    
//    [webView loadData:_data MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
//    
//    [_scrollView addSubview:webView];
    
    _fullImageView.image = [UIImage sd_animatedGIFWithData:_data];
    
}


@end
