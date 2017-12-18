//
//  ImageTextView.m
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "ImageTextView.h"
#import "TextColorItem.h"
#import "ZQUtil.h"

@interface ImageTextView ()
{
    TextColorBlock _colorBlock;
    TextFontBlock _fontBlock;
    
    UIView *_colorChoseView;
    UIView *_fontView;
    UIView *_colorShowView;
    
    UIScrollView *_scrollView;
}
@end

@implementation ImageTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
//        [self addTestBorderToSubviews];
    }
    return self;
}

-(void)buildUI
{
    self.backgroundColor = [ZQUtil R:244 G:244 B:244 A:1];
    
    [self addColorView];
    
    [self addFontView];
    
}

-(void)addColorView
{
    _colorChoseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 20)];
    _colorChoseView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_colorChoseView];
    NSInteger colorCount = 10;
    CGFloat marginX = 20.0f;
    CGFloat viewWidth = (_colorChoseView.width - 2*marginX)/colorCount;
    for (NSInteger i = 0; i<colorCount; i++) {
        CGFloat viewX = marginX + i*viewWidth;
        TextColorItem *colorItem = [[TextColorItem alloc] initWithFrame:CGRectMake(viewX, 0, viewWidth, _colorChoseView.height)];
        colorItem.color = [ZQUtil getRandomColor];
        [_colorChoseView addSubview:colorItem];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colorTapMethod:)];
        [colorItem addGestureRecognizer:tap];
    }
}

-(void)addFontView
{
    UIView *fontView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.width, self.height - 20)];
    [self addSubview:fontView];
    
    CGFloat marginX = 20.0f;
    CGFloat imageHeight = 30.0f;
    _colorShowView = [[UIView alloc] initWithFrame:CGRectMake(marginX, 0, imageHeight, imageHeight)];
    _colorShowView.centerY = fontView.height/2.f;
    _colorShowView.layer.cornerRadius = 5.0f;
    _colorShowView.layer.borderWidth = 1.0f;
    _colorShowView.layer.masksToBounds = true;
    _colorShowView.layer.borderColor = [UIColor blackColor].CGColor;
    _colorShowView.backgroundColor = [UIColor blackColor];
    [fontView addSubview:_colorShowView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(_colorShowView.right + marginX, _colorShowView.top, 1, imageHeight)];
    line.backgroundColor = [ZQUtil R:204 G:204 B:204 A:1];
    [fontView addSubview:line];
    
    CGFloat scrollWidth = fontView.width - line.right - marginX;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(line.right + marginX, line.top, scrollWidth, imageHeight)];
    _scrollView.showsHorizontalScrollIndicator = false;
    [fontView addSubview:_scrollView];
    
    CGFloat labelWidth = 100.0f;
    NSArray *fontNames = @[@"SimSun",@"SimHei",@"Kaiti"];
    NSArray *fontTitles = @[@"宋体",@"黑体",@"楷体"];
    for (int i = 0; i<fontNames.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*labelWidth, 0, labelWidth, _scrollView.height)];
        UIFont *font = [UIFont fontWithName:fontNames[i] size:15];
        label.font = font;
        label.text = fontTitles[i];
        label.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:label];
        label.userInteractionEnabled = true;
        _scrollView.contentSize = CGSizeMake(label.right,0);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fontTapMethod:)];
        [label addGestureRecognizer:tap];
    }
}

-(void)colorTapMethod:(UITapGestureRecognizer*)tap
{
    TextColorItem *item = (TextColorItem*)tap.view;
    _colorShowView.backgroundColor = item.color;
    if (_colorBlock) {
        _colorBlock(item.color);
    }
}

-(void)fontTapMethod:(UITapGestureRecognizer*)tap
{
    UILabel *label = (UILabel*)tap.view;
    if (_fontBlock) {
        _fontBlock(label.font);
    }
}

-(void)addBlock:(TextColorBlock)color font:(TextFontBlock)font
{
    _colorBlock = color;
    _fontBlock = font;
}

-(void)reset;
{
    _colorShowView.backgroundColor = [UIColor blackColor];
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:true];
}

@end
