//
//  CenterControl.h
//  HeBeiFM
//
//  Created by 经纬中天 on 16/5/11.
//  Copyright © 2016年 Apple. All rights reserved.
//  全局状态控制及调度

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface CenterControl : NSObject

@property(nonatomic,assign) BOOL isTableEditing;


+(CenterControl *)shareControl;


-(NSString*)fileReviseDate:(NSString*)filePath;

@end
