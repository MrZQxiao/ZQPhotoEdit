//
//  ImageRotateView.m
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//
#import "ImageRotateToolBar.h"

@interface ImageRotateToolBar ()
{
    IntegerBlock _block;
}
@end

@implementation ImageRotateToolBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildLayout];
    }
    return self;
}

-(void)buildLayout
{
    
    self.backgroundColor = [ZQUtil R:244 G:244 B:244 A:1];
    
    NSInteger btnCount = 4;
    CGFloat btnHeight = 35.0f;
    CGFloat marginY = (self.height - btnHeight)/2.0f;
    CGFloat marginX = (self.width - btnHeight * btnCount)/(btnCount + 1);
    
    for (NSInteger i = 0; i<btnCount; i++) {
        CGFloat btnX = (i + 1)*marginX + i*btnHeight;
        UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(btnX, marginY, btnHeight, btnHeight)];
        [button setImage:[UIImage imageNamed:ZQImageName([self btnImages][i])]?:[UIImage imageNamed:ZQFrameworkImageName([self btnImages][i])] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClickMethod:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self addSubview:button];
    }
}

-(NSArray*)btnImages
{
    return @[@"imageRotate1",@"imageRotate2",@"imageRotate3",@"imageRotate4"];
}

-(void)buttonClickMethod:(UIButton*)button
{
    if (_block) {
        _block(button.tag);
    }
}

-(void)addRotateChangeBlock:(IntegerBlock)block
{
    _block = block;
}


@end
