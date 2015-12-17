//
//  ThemeButton.m
//  WeiChi
//
//  Created by imac on 15/9/8.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"
@implementation ThemeButton

-(void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        //注册监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
    }
    return self;
}

-(void)themeDidChange:(NSNotification *)notification{

    //重新加载图片
    [self loadImage];
    

}

-(void)setNormalImageName:(NSString *)normalImageName{

    if(![_normalImageName isEqualToString:normalImageName]){
    
        _normalImageName=[normalImageName copy];
        
        [self loadImage];
    }
    
}
-(void)setHighLightImageName:(NSString *)HighLightImageName{

    if(![_HighLightImageName isEqualToString:HighLightImageName]){
    
        _HighLightImageName=[HighLightImageName copy];
        
        [self loadImage];
    }
}

- (void)loadImage{
    ThemeManager *manager=[ThemeManager shareInstance];
    UIImage *normalImage=[manager getThemeImage:self.normalImageName];
    UIImage *highlightImage=[manager getThemeImage:self.HighLightImageName];
    
    if(normalImage !=nil){
        [self setImage:normalImage forState:UIControlStateNormal];
    }
    if(highlightImage != nil){
        [self setImage:highlightImage forState:UIControlStateNormal];
    }
}


@end
