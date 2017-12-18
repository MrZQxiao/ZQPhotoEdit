//
//  ImageRotateView.h
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQUtil.h"

static CGFloat rotateToolBarHeight = 70.0f;

@interface ImageRotateToolBar : UIView

-(void)addRotateChangeBlock:(IntegerBlock)block;

@end
