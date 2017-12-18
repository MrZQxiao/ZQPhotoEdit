//
//  ImageCropRatioChooseView.m
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "ImageCropRatioChooseView.h"
#import "CropRatioItem.h"
#import "ZQUtil.h"
@interface ImageCropRatioChooseView ()
{
    RatioBlock _block;
    NSMutableArray *_items;
}
@end

@implementation ImageCropRatioChooseView

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
    
    CGFloat bigMargin = 15.0f;
    CGFloat labelWidth = 70.0f;
    CGFloat labelHeight = 30.0f;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(bigMargin, 0, labelWidth, labelHeight)];
    label.centerY = self.height/2.0f;
    label.text = @"裁剪比例";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14];
    label.backgroundColor = [ZQUtil R:183 G:197 B:220 A:1];
    label.layer.cornerRadius = labelHeight/2.0f;
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.masksToBounds = true;
    [self addSubview:label];
    
    CGFloat viewHeight = 55.0f;
    UIView *chooseView = [[UIView alloc] initWithFrame:CGRectMake(label.right + bigMargin, 0, self.width - labelWidth - 3*bigMargin,viewHeight)];
    chooseView.centerY = self.height/2.0f;
    [self addSubview:chooseView];
    
    _items = [NSMutableArray new];
    NSArray *btnTitles = @[@"1:1",@"4:3",@"3:4",@"16:9",@"9:16"];
    CGFloat itemMargin = 10.0f;
    CGFloat itemWidth = (chooseView.width - (btnTitles.count + 1)*itemMargin)/btnTitles.count;
    for (int i = 0; i<btnTitles.count; i++) {
        CGFloat itemX = (i+1)*itemMargin + i*itemWidth;
        CropRatioItem *item = [[CropRatioItem alloc] initWithFrame:CGRectMake(itemX, 0, itemWidth, chooseView.height)];
        item.title = btnTitles[i];
        item.tag = i;
        item.scale = [self scaleFromTitle:btnTitles[i]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClick:)];
        [item addGestureRecognizer:tap];
        [chooseView addSubview:item];
        [_items addObject:item];
    }
}

-(CGFloat)scaleFromTitle:(NSString*)title
{
    CGFloat width = [[title componentsSeparatedByString:@":"].firstObject floatValue];
    CGFloat height = [[title componentsSeparatedByString:@":"].lastObject floatValue];
    return width/height;
}

-(void)itemClick:(UITapGestureRecognizer*)tap
{
    [self reset];
    CropRatioItem *item = (CropRatioItem*)tap.view;
    item.tapSelected = true;
    if (_block) {
        _block([self scaleFromTitle:item.title]);
    }
}

-(void)addRatioChoiceBlock:(RatioBlock)block
{
    _block = block;
}

-(void)reset
{
    for (CropRatioItem *item in _items) {
        item.tapSelected = false;
    }
}
@end
