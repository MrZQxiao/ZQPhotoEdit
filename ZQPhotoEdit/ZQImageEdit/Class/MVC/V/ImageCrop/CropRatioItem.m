//
//  CropRatioItem.m
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "CropRatioItem.h"
#import "ZQUtil.h"

@interface CropRatioItem ()
{
    UIView *_borderView;
    UILabel *_label;
}
@end

@implementation CropRatioItem

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    CGFloat labelHeight = 15.0f;
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - labelHeight, self.frame.size.width, labelHeight)];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:13];
    _label.textColor = [UIColor blackColor];
    [self addSubview:_label];
    
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - labelHeight)];
    containerView.userInteractionEnabled = true;
    [self addSubview:containerView];
    
    _borderView = [[UIView alloc] initWithFrame:containerView.bounds];
    _borderView.layer.borderWidth = 1.5f;
    _borderView.userInteractionEnabled = true;
    _borderView.layer.borderColor = [UIColor blackColor].CGColor;
    [containerView addSubview:_borderView];
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    _label.text = title;
}

-(void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    CGPoint center = _borderView.center;
    
    if (scale >= 1) {
        _borderView.height = _borderView.height / scale;
    }else{
        _borderView.width = _borderView.width * scale;
    }
    _borderView.center = center;
}

-(void)setTapSelected:(BOOL)tapSelected
{
    _tapSelected = tapSelected;
    
    _borderView.layer.borderWidth = _tapSelected ? 3.0f : 1.5f;
}

@end
