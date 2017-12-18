//
//  ImageMosicToolBar.h
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LineWidthBlock)(CGFloat lineWidth);

static CGFloat mosaicToolBarHeight = 70.0f;

@interface ImageMosaicToolBar : UIView

-(void)addLineWidthChangeBlock:(LineWidthBlock)block;

@end
