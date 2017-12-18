//
//  ImageFilterToolBar.m
//  ZQPhotoEdit
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "ImageFilterToolBar.h"
#import "ZQUtil.h"

@interface ImageFilterToolBar()

{
    StringBlock _block;
}

@end


@implementation ImageFilterToolBar
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
    
    NSInteger btnCount = 8;
    CGFloat btnH = 35.0f;
    CGFloat btnW = self.width/4;
//    CGFloat marginX = (self.width - btnHeight * btnCount)/(btnCount + 1);
    
    for (NSInteger i = 0; i<btnCount; i++) {
        CGFloat btnX = (i%4)*btnW;
        CGFloat btnY = i/4 *btnH;

        UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:[self btnTitles][i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClickMethod:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self addSubview:button];
    }
}

-(NSArray*)btnTitles
{
    return @[@"滤镜1",@"滤镜2",@"滤镜3",@"滤镜4",@"滤镜5",@"滤镜6",@"滤镜7",@"滤镜8"];
}

//滤镜效果
- (NSArray *)filterNames{
    
       return @[
                        @"CIPhotoEffectChrome",
                        @"CIPhotoEffectFade",
                        @"CIPhotoEffectInstant",
                        @"CIPhotoEffectMono",
                        @"CIPhotoEffectNoir",
                        @"CIPhotoEffectProcess",
                        @"CIPhotoEffectTonal",
                        @"CIPhotoEffectTransfer"
                ];
   
}


-(void)buttonClickMethod:(UIButton*)button
{
    if (_block) {
        _block([self filterNames][button.tag]);
    }
}

-(void)addRotateChangeBlock:(StringBlock)block
{
    _block = block;
}



@end
