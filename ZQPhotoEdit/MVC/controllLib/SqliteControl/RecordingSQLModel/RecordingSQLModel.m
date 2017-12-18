//
//  RecordingSQLModel.m
//  移动采编系统
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "RecordingSQLModel.h"
#import <AVFoundation/AVFoundation.h>


@implementation RecordingSQLModel

-(NSString *)filePath
{

            return [NSString stringWithFormat:@"%@/%@",ImageDir,_filePath.lastPathComponent];
}

@end
