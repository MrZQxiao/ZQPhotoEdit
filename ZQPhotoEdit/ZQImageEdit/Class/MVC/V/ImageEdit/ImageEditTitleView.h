//
//  ImageEditTitleView.h
//  移动采编
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ZQUtil.h"

@interface ImageEditTitleView : UIView

-(void)addBackBlock:(VoidBlock)block saveBlock:(VoidBlock)saveBlock;

@property (nonatomic,copy) NSString *title;

@end
