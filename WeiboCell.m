//
//  WeiboCell.m
//  WeiChi
//
//  Created by imac on 15/9/11.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "WeiboCell.h"
#import "UIImageView+WebCache.h"
#import "ThemeManager.h"
@implementation WeiboCell




- (void)awakeFromNib {
    
    self.selectionStyle =    UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor clearColor];
    //创建微博内容View
    _weiboView = [[WeiboView alloc]initWithFrame:CGRectZero];
    _weiboView.backgroundColor=[UIColor clearColor];
    [self.contentView addSubview:_weiboView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange:) name:kThemeDidChangeNotificationName object:nil];
    
}
-(void)themeChange:(NSNotification *)notification{
    _nickName.textColor = [[ThemeManager shareInstance]getThemeColor:@"Timeline_Content_color"];
    _rePostLabel.textColor = [[ThemeManager shareInstance]getThemeColor:@"Timeline_Content_color"];
    
    _commentLabel.textColor = [[ThemeManager shareInstance]getThemeColor:@"Timeline_Content_color"];
    _srLabel.textColor = [[ThemeManager shareInstance]getThemeColor:@"Timeline_Content_color"];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setLayoutFrame:(WeiboViewLayoutFrame *)layoutFrame{
    if(_layoutFrame !=layoutFrame){
        _layoutFrame = layoutFrame;
        [self setNeedsLayout];
    }
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    //获取微博 model
    WeiboModel *_model = _layoutFrame.weiboModel;
    
    //用户头像
    NSString *urlstr = _model.userModel.profile_image_url;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:urlstr]];
    //用户昵称
    _nickName.text = _model.userModel.screen_name;
    _nickName.font = [UIFont systemFontOfSize:14];
    _nickName.textColor = [[ThemeManager shareInstance]getThemeColor:@"Timeline_Content_color"];
    //
    _rePostLabel.text = [NSString stringWithFormat:@"转发:%@",_model.repostsCount];
    _rePostLabel.font = [UIFont systemFontOfSize:14];

    
    _rePostLabel.textColor = [[ThemeManager shareInstance]getThemeColor:@"Timeline_Content_color"];
    _commentLabel.text = [NSString stringWithFormat:@"评论：%@",_model.commentsCount];
    _commentLabel.font = [UIFont systemFontOfSize:14];

    
    _commentLabel.textColor = [[ThemeManager shareInstance]getThemeColor:@"Timeline_Content_color"];
    //
    
    _srLabel.text = _model.source;
    _srLabel.font = [UIFont systemFontOfSize:14];

    _srLabel.textColor = [[ThemeManager shareInstance]getThemeColor:@"Timeline_Content_color"];
    //微博内容
    _weiboView.layoutFrame = _layoutFrame;
    
    _weiboView.frame = _layoutFrame.frame;
}

@end
