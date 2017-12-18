//
//  UIBarButtonItem+Extension.h
//  ZQMusicDemo
//
//  Created by 肖兆强 on 2017/3/4.
//  Copyright © 2017年 BTV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface UIBarButtonItem (Extension)



+(UIBarButtonItem*)barButtonItemWithImage:(NSString *)barButtonImage target:(id)target selector:(SEL)selctor;

+ (instancetype)barButtonItemWithImageName:(NSString *)imagename highImageName:(NSString *)highImagename targate:(id)targate select:(SEL)select;

+(UIBarButtonItem*)barButtonItemWithTitle:(NSString*)title titleColor:(UIColor*)color titleFont:(UIFont*)font target:(id)target selector:(SEL)selctor;

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title  target:(id)target action:(SEL)action;


@end
