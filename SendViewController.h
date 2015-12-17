//
//  SendViewController.h
//  WeiChi
//
//  Created by imac on 15/9/17.
//  Copyright (c) 2015年 imac. All rights reserved.
//

#import "BaseViewController.h"
#import "ZoomImageView.h"
@interface SendViewController : BaseViewController<ZoomImageViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{

    //1 文本编辑栏
    UITextView *_textView;
    
    //2 工具栏
    UIView *_editorBar;
    
    //3 显示缩略图
    ZoomImageView *_zoomImageView;
}
@end
