//
//  ImageFilterToolBar.h
//  ZQPhotoEdit
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQUtil.h"

static CGFloat FilterToolBarHeight = 70.0f;

@interface ImageFilterToolBar : UIView

-(void)addRotateChangeBlock:(StringBlock)block;


@end
