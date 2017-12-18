//
//  ImageTextView.h
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat textViewHeight = 90.0f;

typedef void(^TextColorBlock)(UIColor *color);

typedef void(^TextFontBlock)(UIFont *font);

@interface ImageTextView : UIView

-(void)addBlock:(TextColorBlock)color font:(TextFontBlock)font;

-(void)reset;

@end
