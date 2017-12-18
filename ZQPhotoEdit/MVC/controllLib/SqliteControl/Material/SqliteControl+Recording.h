//
//  SqliteControl+Recording.h
//  移动采编系统
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "SqliteControl.h"
#import "RecordingSQLModel.h"

@interface SqliteControl (Recording)
/**
 *  创建录制表
 *
 *  
 */
-(BOOL)creatRecordingModelTable;

/**
 *  插入录制表一条数据
 *
 */
-(BOOL)insertOneRecordingModel:(id)model;

/**
 
 主要应用于文件引用计数
 
 */
-(BOOL)updateOneModelWithModel:(RecordingSQLModel *)model;
/**
 *  录制表中一条数据存在不存在
 *
 */
-(BOOL)isFileIDEixt:(NSString *)fileID;
/**
 *  删除录制表中一条数据
 *
 */
-(BOOL)deleteWithFileID:(NSString *)fileID;
/**
 *  读取录制表的所有数据
 */
-(NSArray *)readAllRecordingModel;

-(void)insertFileWithModelArr:(NSArray *)arr;

-(RecordingSQLModel *)readOneRecordingModelWithFileId:(NSString *)fileId;

/**
 *  清空录制表的所有数据
 */
-(BOOL)deleteAllRecordingModel;
/**
 *  清空录制表的所有数据
 */
@end
