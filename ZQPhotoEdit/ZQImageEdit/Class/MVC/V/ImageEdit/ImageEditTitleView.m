//
//  ImageEditTitleView.m
//  移动采编
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "ImageEditTitleView.h"
#import "ZQUtil.h"

@interface ImageEditTitleView ()
{
    UILabel *_titleLabel;
    
    VoidBlock _backBlock;
    
    VoidBlock _saveBlock;
}
@end

@implementation ImageEditTitleView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    self.backgroundColor = [ZQUtil R:131 G:128 B:118 A:1];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
    
    [backBtn setImage:[UIImage imageNamed:ZQImageName(@"viewBackButton")]?:[UIImage imageNamed:ZQFrameworkImageName(@"viewBackButton")] forState:UIControlStateNormal];
    backBtn.centerY = 42;
    [backBtn addTarget:self action:@selector(backMethod) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 40, 0, 30, 30)];
    
    [saveButton setImage:[UIImage imageNamed:ZQImageName(@"imageEdit_save")]?:[UIImage imageNamed:ZQFrameworkImageName(@"imageEdit_save")] forState:UIControlStateNormal];
    saveButton.centerY = 42;
    [saveButton addTarget:self action:@selector(saveMethod) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:saveButton];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    _titleLabel.centerY = 42;
    _titleLabel.centerX = self.width/2.0f;
    _titleLabel.textColor = [ZQUtil R:88 G:105 B:151 A:1];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
}

-(void)addBackBlock:(VoidBlock)block saveBlock:(VoidBlock)saveBlock
{
    _backBlock = block;
    
    _saveBlock = saveBlock;
}

-(void)backMethod
{
    _backBlock();
}

-(void)saveMethod
{
    _saveBlock();
}

-(void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

@end
