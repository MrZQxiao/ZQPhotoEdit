//
//  UIBarButtonItem+Extension.m
//  ZQMusicDemo
//
//  Created by 肖兆强 on 2017/3/4.
//  Copyright © 2017年 BTV. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "UIView+Extension.h"
#import "ZQUtil.h"


#import "UIBarButtonItem+Extension.h"


@implementation UIBarButtonItem (Extension)




+(UIBarButtonItem*)barButtonItemWithImage:(NSString *)barButtonImage target:(id)target selector:(SEL)selctor{
    UIButton*btn=[[UIButton alloc]init];
    [btn  addTarget:target action:selctor forControlEvents:UIControlEventTouchUpInside];
    [btn setContentMode:UIViewContentModeCenter];
    
    UIImage*btnImage=[UIImage imageNamed:barButtonImage];
    btn.frame=CGRectMake(0, 0, btnImage.size.width, btnImage.size.height);
    [btn setImage:btnImage forState:UIControlStateNormal];
    btn.imageView.contentMode=UIViewContentModeCenter;
    UIBarButtonItem*buttonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    return buttonItem;
}

+ (instancetype)barButtonItemWithImageName:(NSString *)imagename highImageName:(NSString *)highImagename targate:(id)targate select:(SEL)select;
{
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
    
    [btn setBackgroundImage:[UIImage imageNamed:highImagename] forState:UIControlStateHighlighted];
    
    btn.size = btn.currentBackgroundImage.size;
    [btn addTarget:targate action:select forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barbutton = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return barbutton;
}


+(UIBarButtonItem*)barButtonItemWithTitle:(NSString*)title titleColor:(UIColor*)color titleFont:(UIFont*)font target:(id)target selector:(SEL)selctor {
    UIButton*btn=[[UIButton alloc]init];
    [btn addTarget:target action:selctor forControlEvents:UIControlEventTouchUpInside];
    [btn setContentMode:UIViewContentModeCenter];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font=font;
    btn.frame=CGRectMake(0, 0, [title sizeWithAttributes:@{NSFontAttributeName:font}].width, [title sizeWithAttributes:@{NSFontAttributeName:font}].height);
    UIBarButtonItem*btnItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    return btnItem;
}
+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title  target:(id)target action:(SEL)action;
{
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.titleLabel.textColor = [UIColor whiteColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setTitleColor:RGB(211, 211, 211) forState:UIControlStateDisabled];
    // 设置按钮的尺寸为背景图片的尺寸
    //    button.size = button.currentBackgroundImage.size;
    button.size = CGSizeMake(35, 35);
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


@end
