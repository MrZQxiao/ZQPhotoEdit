//
//  UIColor+HEX.h
//  iSchool
//
//  Created by 黎未来 on 15/7/10.
//  Copyright (c) 2015年 iiSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HEX)

+ (UIColor *) colorWithHexString: (NSString *)color;
+ (UIColor *) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

@end
