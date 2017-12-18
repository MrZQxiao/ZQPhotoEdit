//
//  TextColorView.m
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "TextColorItem.h"
#import "ZQUtil.h"

@interface TextColorItem ()
{
    UIView *_colorView;
}
@end

@implementation TextColorItem

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    CGFloat colorHiehgt = 7.0f;
    
    _colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, colorHiehgt)];
    _colorView.centerY = self.height/2.0f;
    [self addSubview:_colorView];
}

-(void)setColor:(UIColor *)color
{
    _color = color;
    _colorView.backgroundColor = color;
}

@end
