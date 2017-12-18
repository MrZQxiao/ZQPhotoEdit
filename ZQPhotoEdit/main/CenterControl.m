//
//  CenterControl.m
//  HeBeiFM
//
//  Created by 经纬中天 on 16/5/11.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "CenterControl.h"

#import <Accelerate/Accelerate.h>

#import "MJExtension.h"




@interface CenterControl ()
{
    NSMutableArray *_pathArr;
    NSTimer *_messageUpdateTimer;
}
@end

@implementation CenterControl

+(CenterControl *)shareControl
{
    static CenterControl *shareControlInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareControlInstance = [[self alloc] init];
    });
    return shareControlInstance;
}

-(instancetype)init
{
    if (self = [super init]) {
       
    }
    return self;
}




//文件修改日期
-(NSString*)fileReviseDate:(NSString*)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:filePath error:nil];
    NSDate *reviseDate = [fileAttributes objectForKey:NSFileModificationDate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:reviseDate];
    return dateString;
}


@end
