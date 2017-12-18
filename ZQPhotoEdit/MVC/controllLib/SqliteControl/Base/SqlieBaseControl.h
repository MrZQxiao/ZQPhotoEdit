//
//  SqlieBaseControl.h
//  JinCheng
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "FMDatabaseQueue.h"
#import "MJExtension.h"
#import "RecordingSQLModel.h"

@class FMDatabase;
@interface SqlieBaseControl : NSObject
@property (nonatomic,strong) FMDatabase *db;

-(BOOL)OpenDB;
/**
 *  #pragma mark - 在某一个表增加某个字段
 */
-(BOOL)insertColumnInTable:(NSString *)table column:(NSString *)columName type:(NSString *)columType;

/**
 *  判断一个表是否存在
 *
 *  @param tableName 表名
 *
 *  
 */
-(BOOL)isTableExit:(NSString *)tableName;
-(NSString *)currentTime;
#pragma mark -  字符串转换成日期

- (NSDate *)stringTodate:(NSString *)date;
-(NSString *)dateTostring:(NSDate *)date;
- (NSString *)docPath;
-(NSString *)libPrefPath;
-(NSString *)libCachePath;
- (NSString *)tmpPath;
-(NSString *)dicToDataString:(NSDictionary *)dic;
-(NSString *)arrToDataString:(NSArray *)arr;
-(id )jsonStringTojsonObject:(NSString *)jsonString;
@end
