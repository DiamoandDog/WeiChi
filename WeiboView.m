//
//  WeiboView.m
//  WeiChi
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "WeiboView.h"
#import "UIImageView+WebCache.h"
#import "ThemeManager.h"
@implementation WeiboView
//xib文件创建
//- (instancetype)initWithCoder:(NSCoder *)aDecoder{
//
//}


-(void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(instancetype)initWithFrame:(CGRect)frame{

    self=[super initWithFrame:frame];
    if(self){
    
        [self _createSubViews];
    }
    return self;
}

- (void)setLayoutFrame:(WeiboViewLayoutFrame *)layoutFrame{
    if(_layoutFrame !=layoutFrame){
        _layoutFrame = layoutFrame;
        
        [self setNeedsLayout];
    }
}

- (void)_createSubViews{
    _textLabel.backgroundColor = [UIColor redColor];
    _sourceLabel.backgroundColor = [UIColor yellowColor];
    //微博内容
    _textLabel = [[WXLabel alloc]initWithFrame:CGRectZero];
    _textLabel.font = [UIFont systemFontOfSize:15];
    _textLabel.textColor = [[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];
    _textLabel.linespace =4;
    _textLabel.wxLabelDelegate=self;
    
    [self addSubview:_textLabel];

    
    //
    _sourceLabel = [[WXLabel alloc]initWithFrame:CGRectZero];
    _sourceLabel.textColor = [[ThemeManager shareInstance]getThemeColor:@"Timeline_Content_color"];
    _sourceLabel.linespace=4;
    _sourceLabel.font=[UIFont systemFontOfSize:14];
    _sourceLabel.wxLabelDelegate=self;
    [self addSubview:_sourceLabel];
    
    //微博图片
    _imgView = [[ZoomImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:_imgView];
    
    //背景图片
    _bgImageView = [[ThemeImageView alloc]initWithFrame:CGRectZero];
    //[self addSubview:_bgImageView];
    _bgImageView.leftCapWidth=35;
    _bgImageView.topCapWidth=20;
    _bgImageView.imgName = @"timeline_rt_border_9.png";
    
    [self insertSubview:_bgImageView atIndex:0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange:) name:kThemeDidChangeNotificationName object:nil];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _textLabel.font = [UIFont systemFontOfSize:FontSize_weibo(_layoutFrame.isDetail)];
    _sourceLabel.font=[UIFont systemFontOfSize:FontSize_reWeibo(_layoutFrame.isDetail)];

    WeiboModel *weiboModel = _layoutFrame.weiboModel;
    //设置整个weiboView的frame
    //self.frame = _layoutFrame.frame;
    
    _textLabel.frame = _layoutFrame.textFrame;
    _textLabel.text = weiboModel.text;
    
    //是否转发
    if(weiboModel.reWeiboModel !=nil){
        _bgImageView.hidden = NO;
        _sourceLabel.hidden = NO;
        
        //背景图片frame
        _bgImageView.frame = _layoutFrame.bgImageFrame;
        
        //原微博内容及frame
        _sourceLabel.frame = _layoutFrame.srTextFrame;
        _sourceLabel.text = weiboModel.reWeiboModel.text;
        
        //图片
        NSString *imageUrl = weiboModel.reWeiboModel.thumbnailImage;
        if(imageUrl !=nil){
            _imgView.hidden=NO;
            _imgView.frame = _layoutFrame.imgFrame;
            [_imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            
            //大图链接
            _imgView.fullImageUrlString = weiboModel.reWeiboModel.originalImage;
        }else{
        
            _imgView.hidden = YES;
        }
    }else{
        //隐藏不用的View
        _bgImageView.hidden = YES;
        _sourceLabel.hidden = YES;
        //图片
        NSString *imageUrl = weiboModel.thumbnailImage;
        if(imageUrl !=nil){
            _imgView.hidden =NO;
            _imgView.frame = _layoutFrame.imgFrame;
            [_imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
            
            _imgView.fullImageUrlString = weiboModel.originalImage;
        }else{//没有图片
            _imgView.hidden=YES;
            
        }
    }
    //判断gif
    if(_imgView.hidden == NO){
        
        NSString *extension;
        UIImageView *iconView = _imgView.iconView;
        iconView.frame = CGRectMake(_imgView.width - 24, _imgView.height-15, 24, 15);
        if(weiboModel.reWeiboModel != nil){
            extension  = [weiboModel.reWeiboModel.thumbnailImage pathExtension];
        }else{
            extension = [weiboModel.thumbnailImage pathExtension];
        }
        if([extension isEqualToString:@"gif"]){
            _imgView.isGif =YES;
            iconView.hidden=NO;
        }else {
            _imgView.isGif = NO;
            iconView.hidden=YES;
        }
    }
    
}
-(NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel{

    NSString *regex1=@"@\\w+";
    NSString *regex2=@"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3=@"#\\w+#";
    NSString *regex=[NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    return regex;
    
}

-(UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel{
    return [[ThemeManager shareInstance]getThemeColor:@"Link_color"];
    
}

-(UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel{



    return [UIColor blueColor];
}

- (void)themeChange:(NSNotification *)notification{

    _textLabel.textColor = [[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];
    _sourceLabel.textColor = [[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];
}
@end














