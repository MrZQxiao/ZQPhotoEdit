//
//  ImageBrightnessView.h
//  ZQPhotoEdit
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat BrightnessToolBarHeight = 80.0f;

@protocol ImageBrightnessViewDelegate <NSObject>

- (void)brightnessChangeWithTag:(NSInteger)tag Value:(CGFloat)value;

@end

@interface ImageBrightnessView : UIView

@property (nonatomic,weak)id<ImageBrightnessViewDelegate>delegate;

@end
