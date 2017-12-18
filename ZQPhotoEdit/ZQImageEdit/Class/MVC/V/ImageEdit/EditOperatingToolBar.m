//
//  EditOperatingToolBar.m
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "EditOperatingToolBar.h"

@interface EditOperatingToolBar ()
{
    IntegerBlock _block;
}
@end

@implementation EditOperatingToolBar

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
    self.backgroundColor = [UIColor whiteColor];
    CGFloat btnHeight = 30.0f;
    CGFloat margin = 10.0f;
    CGFloat btnY = (self.bounds.size.height - btnHeight)/2.0f;
    NSArray *btnImages = @[@"operaBar_close",@"operaBar_reload",@"operaBar_save"];
    
    for (int i = 0; i<btnImages.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, btnY, btnHeight, btnHeight)];
        
        [button setImage:[UIImage imageNamed:ZQImageName(btnImages[i])]?:[UIImage imageNamed:ZQFrameworkImageName(btnImages[i])] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClickMethod:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        switch (i) {
            case 0:
                button.left = margin;
                button.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
                break;
            case 1:
                button.centerX = self.width/2.0f;
                break;
            case 2:
                button.right = self.width - margin;
                break;
            default:
                break;
        }
        [self addSubview:button];
    }
}

-(void)btnClickMethod:(UIButton*)button
{
    if (_block) {
        _block(button.tag);
    }
}

-(void)addTapBlock:(IntegerBlock)block
{
    _block = block;
}

@end
