//
//  WeiboModel.m
//  XSWeibo
//
//  Created by gj on 15/9/9.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "WeiboModel.h"
#import "RegexKitLite.h"
@implementation WeiboModel


- (NSDictionary*)attributeMapDictionary{
    
    //   @"属性名": @"数据字典的key"
    NSDictionary *mapAtt = @{
                             @"createDate":@"created_at",
                             @"weiboId":@"id",
                             @"text":@"text",
                             @"source":@"source",
                             @"favorited":@"favorited",
                             @"thumbnailImage":@"thumbnail_pic",
                             @"bmiddlelImage":@"bmiddle_pic",
                             @"originalImage":@"original_pic",
                             @"geo":@"geo",
                             @"repostsCount":@"reposts_count",
                             @"commentsCount":@"comments_count",
                             @"weiboIdStr":@"idstr"
                             };
    
    return mapAtt;
}

-(void)setAttributes:(NSDictionary *)dataDic{

    [super setAttributes:dataDic];
    //微博来源
    if(_source != nil){
    
        NSString *regex = @">.+<";
        NSArray *array = [_source componentsMatchedByRegex:regex];
        if(array.count != 0){
            NSString *temp = array[0];
            temp = [temp substringWithRange:NSMakeRange(1,temp.length -2)];
            _source = [NSString stringWithFormat:@"来源:%@",temp];
        }
    }
    
    
    
    //用户信息
    NSDictionary *userDic =[dataDic objectForKey:@"user"];
    if(userDic != nil){
        _userModel = [[UserModel alloc]initWithDataDic:userDic];
        
    }
    //被转发的微博
    NSDictionary *reWeiboDic = [dataDic objectForKey:@"retweeted_status"];
    if(reWeiboDic !=nil){
        _reWeiboModel = [[WeiboModel alloc]initWithDataDic:reWeiboDic];
    //被转发的用户名
        NSString *name = _reWeiboModel.userModel.name;
        _reWeiboModel.text = [NSString stringWithFormat:@"@%@:%@",name,_reWeiboModel.text];
    }
    
    //找到微博中表情的字符串
    NSString *regex = @"\\[\\w+\\]";
    NSArray *faceItems = [_text componentsMatchedByRegex:regex];
    
    //在plist文件中找到相应的png
    //emoticons.plist
    NSString *configPath = [[NSBundle mainBundle]pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *faceConfigArray = [NSArray arrayWithContentsOfFile:configPath];
    
    for(NSString *faceName in faceItems){
    
        NSString *t = [NSString stringWithFormat:@"self.chs='%@'",faceName];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:t];
        NSArray *items = [faceConfigArray filteredArrayUsingPredicate:predicate];
        
        if(items.count >0){
        
            NSDictionary *faceDic = items[0];
            //
            NSString *imageName = [faceDic objectForKey:@"png"];
            
            NSString *replaceString = [NSString stringWithFormat:@"<image url = '%@'>",imageName];
            //
            self.text = [self.text stringByReplacingOccurrencesOfString:faceName withString:replaceString];
        }
    }
    
    
    
}

@end
