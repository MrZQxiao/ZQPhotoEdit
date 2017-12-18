//
//  ImageCropViewController.h
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//  图片裁剪

#import <UIKit/UIKit.h>
#import "ZQUtil.h"


@interface ZQImageCropController : UIViewController

@property (nonatomic,strong) UIImage *image;

-(void)addFinishBlock:(ImageBlock)block;


@end
