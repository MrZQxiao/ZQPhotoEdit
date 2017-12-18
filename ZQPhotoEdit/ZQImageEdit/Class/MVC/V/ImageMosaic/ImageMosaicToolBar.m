//
//  ImageMosicToolBar.m
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "ImageMosaicToolBar.h"
#import "ZQUtil.h"

@interface ImageMosaicToolBar ()
{
    UIImageView *_imageView;
    LineWidthBlock _block;
    NSMutableArray *_buttons;
}
@end

@implementation ImageMosaicToolBar

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
    CGFloat marginX = 20.0f;
    CGFloat marginY = 10.0f;
    CGFloat imageHeight = self.bounds.size.height - 2*marginY;
    CGFloat imageWidth = imageHeight * 1.3f;
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(marginX, marginY, imageWidth, imageHeight)];
    
    _imageView.image = [UIImage imageNamed:ZQImageName(@"mosaicTestView")]?:[UIImage imageNamed:ZQFrameworkImageName(@"mosaicTestView")];
    _imageView.layer.borderWidth = 1.0f;
    _imageView.layer.borderColor = [UIColor blackColor].CGColor;
    _imageView.hidden = true;
    [self addSubview:_imageView];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - imageHeight - marginX, marginY, imageHeight, imageHeight)];
    
    logo.image = [UIImage imageNamed:ZQImageName(@"mosaicLogo")]?:[UIImage imageNamed:ZQFrameworkImageName(@"mosaicLogo")];
    logo.hidden = true;
    [self addSubview:logo];
    
    CGFloat buttonViewWidth = self.width - 4*marginX - imageWidth - imageHeight;
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(_imageView.right + marginX, 0, buttonViewWidth, self.height)];
    [self addSubview:buttonView];
    
    NSInteger buttonCount = 5;
    CGFloat buttonHeight = 25.0f;
    CGFloat buttonMargin = (buttonViewWidth - buttonCount*buttonHeight)/(buttonCount - 1);
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(buttonHeight/2.0f, buttonView.height/2.0f, buttonViewWidth - buttonHeight, 1)];
    line.backgroundColor = [ZQUtil R:204 G:204 B:204 A:1];
    [buttonView addSubview:line];
    
    _buttons = [NSMutableArray new];
    for (int i = 0; i<buttonCount; i++) {
        CGFloat targetWidth = buttonHeight - (buttonCount - i)*2;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*(buttonHeight + buttonMargin), 0, targetWidth , targetWidth)];
        button.layer.cornerRadius = targetWidth/2.0f;
        button.centerY = buttonView.height/2.0f;
      
        [button setImage:[UIImage imageNamed:ZQImageName(@"mosaic_size_normal")]?:[UIImage imageNamed:ZQFrameworkImageName(@"mosaic_size_normal")] forState:UIControlStateNormal];
        [button setImage:  [UIImage imageNamed:ZQImageName(@"mosaic_size_selected")]?:[UIImage imageNamed:ZQFrameworkImageName(@"mosaic_size_selected")] forState:UIControlStateSelected];
        button.layer.masksToBounds = true;
        if (i == 0) {
            button.selected = true;
        }
        [button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [buttonView addSubview:button];
        [_buttons addObject:button];
    }
}

-(void)buttonSelected:(UIButton*)button
{
    for (UIButton *button in _buttons) {
        button.selected = false;
    }
    button.selected = true;
    if (_block) {
        _block(button.width);
    }
}

-(void)addLineWidthChangeBlock:(LineWidthBlock)block
{
    _block = block;
}
@end
