//
//  ThemeLabel.m
//  WeiChi
//
//  Created by imac on 15/9/9.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "ThemeLabel.h"
#import "ThemeManager.h"
@implementation ThemeLabel

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
    
    
    [self loadColor];
}

- (void)setColorName:(NSString *)colorName{
    
    if(![_colorName isEqualToString:colorName]){
        _colorName=[colorName copy];
        
        [self loadColor];
    }
}

- (void)loadColor{
    //得到管家对象
    ThemeManager *manager = [ThemeManager shareInstance];
    self.textColor = [manager getThemeColor:self.colorName];
    
}
@end
