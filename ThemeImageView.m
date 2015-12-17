//
//  ThemeImageView.m
//  WeiChi
//
//  Created by imac on 15/9/8.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"
@implementation ThemeImageView

-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeImageChange:) name:kThemeDidChangeNotificationName object:nil];
    }
    return self;
}

-(void)themeImageChange:(NSNotification *)notification{


    [self loadImage];
}

- (void)setImgName:(NSString *)imgName{

    if(![_imgName isEqualToString:imgName]){
        _imgName=[imgName copy];
        
        [self loadImage];
    }
}

- (void)loadImage{
    //得到管家对象
    ThemeManager *manager = [ThemeManager shareInstance];
    UIImage *image = [manager getThemeImage:self.imgName];
    UIImage *ppImage = [image stretchableImageWithLeftCapWidth:_leftCapWidth topCapHeight:_topCapWidth];
    
    if(image != nil){
        self.image=ppImage;
    
    }
}

@end
