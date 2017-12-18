//
//  SqlieBaseControl.m
//  JinCheng
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "SqlieBaseControl.h"
#import "FMDB.h"
#import "FMDatabaseQueue.h"



@interface SqlieBaseControl ()
{
    
    NSString *_filePath;
}
@end
@implementation SqlieBaseControl
#pragma mark - 在某一个表增加某个字段
-(BOOL)insertColumnInTable:(NSString *)table column:(NSString *)columName type:(NSString *)columType
{
    if ([self OpenDB]) {
        if (![self.db columnExists:columName inTableWithName:table]) {
            NSString *sql = [NSString stringWithFormat:@"alter table %@ add column %@ %@",table,columName,columType];
            if([self.db executeUpdate:sql]){
                
                return YES;
                
            }
        }else{
            
            return YES;
        }
    }
    return NO;
}

#pragma mark - 打开数据库
-(BOOL)OpenDB
{
    
    //1.获得数据库文件的路径
    NSString *libCachePath =[self libCachePath];
    
    NSString *fileName = [libCachePath stringByAppendingPathComponent:@"CZDB.sqlite"];
    _filePath = fileName;
    //    NSLog(@"文件路径%@",fileName);
    //2.获得数据库
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    self.db = db;
    //查询
    if ([db open])
    {
        
        return YES;
        
    }else{
        NSLog(@"数据库打开失败");
        return NO;
        
    }
}


#pragma mark - 查询表是否存在
-(BOOL)isTableExit:(NSString *)tableName
{
    //1.获得数据库文件的路径
    NSString *libCachePath =[self libCachePath];
    
    NSString *fileName = [libCachePath stringByAppendingPathComponent:@"CZDB.sqlite"];
    
    NSLog(@"采编3.0-----%@",fileName);
    //2.获得数据库
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    //查询
    if ([db open])
    {
        
        NSLog(@"数据库打开成功");
        if ([db tableExists:tableName]) {
            [db close];
            return YES;
        }
        [db close];
    }
    
    return NO;
    
}
-(NSString *)currentTime
{
    NSDate *today = [NSDate date];//当前时间
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];  // 格式化时间NSDate    
    
    NSString *stringFromDate = [dateFormat stringFromDate:today];
    return stringFromDate;
}
#pragma mark -  字符串转换成日期

- (NSDate *)stringTodate:(NSString *)date
{
    
    NSString *theDate = date;
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss.sss"];
    NSDate *fromdate=[format dateFromString:theDate];
    return fromdate;
}

-(NSString *)dateTostring:(NSDate *)date
{
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss.sss"];  // 格式化时间NSDate
    
    
    
    NSString *stringFromDate = [dateFormat stringFromDate:date];
    return stringFromDate;
}
- (NSString *)docPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

-(NSString *)libPrefPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preferences"];
}

-(NSString *)libCachePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
}

- (NSString *)tmpPath
{
    return [NSHomeDirectory() stringByAppendingFormat:@"/tmp"];
}
-(NSString *)dicToDataString:(NSDictionary *)dic
{
    //NSDictionary转换为Data
    NSError *parseError = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
    
}
-(NSString *)arrToDataString:(NSArray *)arr
{
    //NSDictionary转换为Data
    NSError *parseError = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
    
}
-(id)jsonStringTojsonObject:(NSString *)jsonString
{
    NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil){
        
        return jsonObject;
        
    }else{
        
        // 解析错误
        return nil;
    }
    
    
}


@end
