//
//  XLMosaicView.h
//  FileLibraryDemo
//
//  Created by Apple on 2017/1/16.
//  Copyright © 2017年 Apple. All rights reserved.
//  拖拽马赛克

#import <UIKit/UIKit.h>

@interface XLMosaicView : UIView

@property (nonatomic, strong) UIImage *image;

@property (nonatomic,strong,readonly) UIImage *finisedImage;

@property (nonatomic,assign) CGFloat mosaicWidth;

-(void)resetImage;


@end
