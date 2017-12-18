//
//  ImageWaterMarkView.m
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "ImageWaterMarkView.h"
#import "ZQUtil.h"

@interface ImageWaterMarkView ()
{
    UIScrollView *_scrollView;
    ImageBlock _selectBlock;
    VoidBlock _addBlock;
    NSMutableArray *_imageViews;
    UIImageView *_addNewImageView;
}
@end

@implementation ImageWaterMarkView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    self.backgroundColor = [ZQUtil R:244 G:244 B:244 A:1];
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_scrollView];
    
    
    _addNewImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:ZQImageName(@"addWaterPring")]?:[UIImage imageNamed:ZQFrameworkImageName(@"addWaterPring")]];
    _addNewImageView.userInteractionEnabled = true;
    [_scrollView addSubview:_addNewImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addNewMark)];
    [_addNewImageView addGestureRecognizer:tap];
    
    _imageViews = [[NSMutableArray alloc] init];
}

-(void)setImagePthes:(NSArray *)imagePthes
{
    [self refresh];
    CGFloat marginY = 10.0f;
    CGFloat marginX = 15.0f;
    CGFloat imageHeight = self.height - 2*marginY;
    CGFloat imageWidth = imageHeight * 1.2;
    for (int i = 0; i<imagePthes.count; i++) {
        CGFloat imageX = (i+1)*marginX + i*imageWidth;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, marginY, imageWidth, imageHeight)];
        [_scrollView addSubview:imageView];
        imageView.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapMethod:)];
        [imageView addGestureRecognizer:tap];
        imageView.layer.cornerRadius = 5.0f;
        imageView.layer.masksToBounds = true;
        imageView.tag = i;
        imageView.layer.borderColor = [UIColor blackColor].CGColor;
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [UIImage imageWithContentsOfFile:imagePthes[i]];
        [_imageViews addObject:imageView];
    }
    
    _addNewImageView.frame = CGRectMake((imagePthes.count+1)*marginX + imagePthes.count*imageWidth, marginY, imageWidth,imageHeight);
    _scrollView.contentSize = CGSizeMake(_addNewImageView.right + marginX, 0);
//    [self addTestBorderToSubviews];
}

-(void)refresh
{
    for (UIView *view in _scrollView.subviews) {
        if (view == _addNewImageView) {continue;}
        [view removeFromSuperview];
    }
    [_imageViews removeAllObjects];
}

-(void)imageTapMethod:(UIGestureRecognizer *)gesture
{
    for (UIImageView *imageView in _imageViews) {
        imageView.layer.borderWidth = 0;
    }
    UIImageView *imageView = (UIImageView*)gesture.view;
    imageView.layer.borderWidth = 1.5;
    if (_selectBlock) {
        _selectBlock(imageView.image);
    }
}

-(void)addNewMark
{
    _addBlock();
}

-(void)addWaterMarkSelected:(ImageBlock)selectedBlock addBlock:(VoidBlock)addBlock
{
    _selectBlock = selectedBlock;
    _addBlock = addBlock;
}

@end
