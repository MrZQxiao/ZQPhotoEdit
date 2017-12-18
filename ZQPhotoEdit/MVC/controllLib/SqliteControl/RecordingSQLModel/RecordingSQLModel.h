//
//  RecordingSQLModel.h
//  移动采编系统
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RecordingSQLModel : NSObject

@property (nonatomic,strong) NSString *filePath;

@property (nonatomic,strong) NSString *fileID;

@property (nonatomic,strong) NSString *fileDetil;

@property (nonatomic,strong) NSString *fileLocation;

@property (nonatomic,strong) NSString *fileCreatDate;

@property (nonatomic,strong) NSArray *markArr;

@property (nonatomic,strong) NSArray *pauseArr;

@property (nonatomic,strong) NSString *duration;

@property (nonatomic,assign) NSInteger retainCounts;

@property (nonatomic,assign) BOOL isNeedCover;

@end
