//
//  ZQUtil.h
//  FileLibraryDemo
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 图片路径resource.bundle

#define ZQBundleName @"ZQResource.bundle"

#define ZQImageName(imageName) [ZQBundleName stringByAppendingPathComponent:imageName]
#define ZQFrameworkImageName(file) [@"Frameworks/ZQImageEdit.framework/ZQResource.bundle" stringByAppendingPathComponent:file]

#define ZQFontName(FontName) [ZQBundleName stringByAppendingPathComponent:FontName]

#define ZQFrameworkFontName(FontName) [@"Frameworks/ZQImageEdit.framework/ZQResource.bundle" stringByAppendingPathComponent:FontName]


//常用Block定义
typedef void(^idBlock)(id data);

typedef void(^StringBlock)(NSString *string);

typedef void(^IntegerBlock)(NSInteger index);

typedef void(^VoidBlock)(void);

typedef void(^ImageBlock)(UIImage *image);


@interface ZQUtil : NSObject

+(UIColor *)getRandomColor;

+(UIColor *)R:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a;

//获取截屏
+(UIImage *)screenShotsOfView:(UIView *)view;



+(NSString *)generateBoundaryString;

@end

//快速设置UIView Frame
@interface UIView (XLChangeViewFrame)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;



@end


