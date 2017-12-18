//
//  WaterMarkControl.m
//  移动采编
//
//  Created by Apple on 2017/2/23.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "WaterMarkControl.h"
#import "ZQUtil.h"

@implementation WaterMarkControl

+(WaterMarkControl*)shareControl
{
    static WaterMarkControl *control = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        control = [[WaterMarkControl alloc] init];
    });
    return control;
}

-(instancetype)init
{
    if (self = [super init]) {
        [self initWaterMarkFileDic];
    }
    return self;
}

-(NSString*)waterMarkDic
{
    return [NSString stringWithFormat:@"%@/Documents/WaterMark", NSHomeDirectory()];
}

-(void)initWaterMarkFileDic
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self waterMarkDic]]) {
        if ([[NSFileManager defaultManager] createDirectoryAtPath:[self waterMarkDic] withIntermediateDirectories:true attributes:nil error:nil]) {
            NSLog(@"创建水印文件夹成功");
//            [self addTestWaterMarks];
        }
    }
}


-(void)addNewWaterMark:(UIImage*)image
{
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@.png",[self waterMarkDic],[ZQUtil generateBoundaryString]];
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:imagePath atomically:true];
}

-(NSArray *)waterMarkPathes
{
    NSFileManager* manager = [NSFileManager defaultManager];
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:[self waterMarkDic]] objectEnumerator];
    NSString* fileName;
    NSMutableArray *fileArr = [[NSMutableArray alloc] init];
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [[self waterMarkDic] stringByAppendingPathComponent:fileName];
        [fileArr addObject:fileAbsolutePath];
    }
    return [NSArray arrayWithArray:fileArr];
}

@end
