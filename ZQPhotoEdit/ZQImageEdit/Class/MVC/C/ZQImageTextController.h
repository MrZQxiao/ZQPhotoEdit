//
//  ImageTextViewController.h
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQUtil.h"
@interface ZQImageTextController : UIViewController

@property (strong,nonatomic) UIImage *image;

-(void)addFinishBlock:(ImageBlock)block;

@end
