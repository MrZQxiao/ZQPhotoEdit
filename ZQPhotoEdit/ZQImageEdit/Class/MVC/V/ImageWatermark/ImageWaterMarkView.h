//
//  ImageWaterMarkView.h
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQUtil.h"

static CGFloat waterViewHeight = 70.0f;

@interface ImageWaterMarkView : UIView

@property (strong,nonatomic) NSArray *imagePthes;

-(void)addWaterMarkSelected:(ImageBlock)selectedBlock addBlock:(VoidBlock)addBlock;


@end
