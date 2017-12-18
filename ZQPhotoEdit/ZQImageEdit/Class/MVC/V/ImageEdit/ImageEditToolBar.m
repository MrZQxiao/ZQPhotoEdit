//
//  ImgeEditToolBar.m
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "ImageEditToolBar.h"

@interface ImageEditToolBar ()

@end

@implementation ImageEditToolBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
//        [self addTestBorderToSubviews];
    }
    return self;
}

-(NSArray*)imageNames
{
    return @[@"imageEdit_toolBar_1",@"imageEdit_toolBar_2",@"imageEdit_toolBar_3",@"imageEdit_toolBar_4",@"imageEdit_toolBar_5",@"imageEdit_toolBar_6",@"imageEdit_toolBar_7"];
}

-(void)buildUI
{
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    
    CGFloat btnHeight = 30.0f;
    CGFloat marginX = (self.bounds.size.width - [self imageNames].count* btnHeight)/([self imageNames].count + 1);
    CGFloat marginY = (self.bounds.size.height - btnHeight)/2.0f;
    
    for (int i = 0; i<[self imageNames].count; i ++) {
        CGFloat btnX = (i + 1)*marginX + i * btnHeight;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(btnX, marginY, btnHeight, btnHeight)];
        
        [button setImage:[UIImage imageNamed:ZQImageName([self imageNames][i])]?:[UIImage imageNamed:ZQFrameworkImageName([self imageNames][i])] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClickMethod:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self addSubview:button];
    }
}

-(void)btnClickMethod:(UIButton*)button
{
    if ([_delegate respondsToSelector:@selector(imageEditToolBarSelectedAtIndex:)]) {
        [_delegate imageEditToolBarSelectedAtIndex:button.tag];
    }
}



@end
