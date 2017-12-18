//
//  SqliteControl.m
//  HeBeiFM
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "SqliteControl.h"

@interface SqliteControl ()

@end
@implementation SqliteControl
+(SqliteControl *)shareControl
{
    static SqliteControl *shareControlInstance = nil;
   
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareControlInstance = [[self alloc] init];
    });
    return shareControlInstance;
}

@end
