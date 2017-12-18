//
//  ImageCropRatioChooseView.h
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat ratioChooseHeight = 70.0f;

typedef void(^RatioBlock)(CGFloat ratio);

@interface ImageCropRatioChooseView : UIView

-(void)reset;

-(void)addRatioChoiceBlock:(RatioBlock)block;

@end
