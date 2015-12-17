//
//  CommentModel.h
//  WeiChi
//
//  Created by imac on 15/9/16.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseModel.h"
#import "UserModel.h"
#import "WeiboModel.h"
@interface CommentModel : BaseModel

@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSString *idstr;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,copy)NSString *source;

@property(nonatomic,retain)UserModel *user;
@property(nonatomic,retain)WeiboModel *weibo;
@property(nonatomic,retain)CommentModel *sourceComment;//源评论
@end
