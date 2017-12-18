//
//  SqliteControl+Recording.m
//  移动采编系统
//
//  Created by 肖兆强 on 2017/6/10.
//  Copyright © 2017年 jwzt. All rights reserved.
//

#import "SqliteControl+Recording.h"



@implementation SqliteControl (Recording)
/**
 *  创建录制表
 *
 *
 */
-(BOOL)creatRecordingModelTable{
    if ([self OpenDB]) {
        
        //创表
        NSString *sql = [NSString stringWithFormat:@"create table if not exists %@(id integer primary key  autoincrement, data text, fileID text,creatDate text)",RecordingTable];
        BOOL result = [self.db executeUpdate:sql];
        
        if (result){
            [self.db close];
            ZQLog(@"创建表成功");
            return YES;
        }else{
            [self.db close];
            ZQLog(@"创建表失败");
            return NO;
        }
        
    }
    return NO;
}

/**
 *  插入录制表一条数据
 *
 */
-(BOOL)insertOneRecordingModel:(id)model{
    if (!model) {
        return NO;
    }
    RecordingSQLModel *model1 = model;
    
    NSDictionary *dic = model1.mj_keyValues;
    if ([self OpenDB]) {
        NSString *jsonString = [self dicToDataString:dic];
        //插入
        NSString *sql = [NSString stringWithFormat:@"insert into %@(data,fileID,creatDate) values('%@','%@','%@')",RecordingTable,jsonString,model1.fileID,model1.fileCreatDate];
        BOOL insert = [self.db executeUpdate:sql];
        if (insert) {
            ZQLog(@"插入数据成功");
            
            [self.db close];
            return YES;
        }else{
            [self.db close];
            ZQLog(@"插入数据失败");
            return NO;
        }
        
    }

    return NO;
}
-(BOOL)updateOneModelWithModel:(RecordingSQLModel *)model
{
    if (!model) {
        return NO;
    }
    if (![self isFileIDEixt:model.fileID]) {
        return NO;
    }
    if ([self OpenDB]) {
        NSDictionary *dic = model.mj_keyValues;
        NSString *jsonString = [self dicToDataString:dic];
        NSString *sql = [NSString stringWithFormat:@"update '%@' set  data = '%@' where fileID = '%@'",RecordingTable,jsonString,model.fileID];
        BOOL update = [self.db executeUpdate:sql];
        if (update) {
            ZQLog(@"更新数据成功");
            [self.db close];
            return YES;
        }else{
            [self.db close];
            ZQLog(@"更新数据失败");
        }
    }

    return NO;
}
/**
 *  录制表中一条数据存在不存在
 *
 */
-(BOOL)isFileIDEixt:(NSString *)fileID{
    if ([self OpenDB]) {
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where fileID = '%@'",RecordingTable,fileID];
        //查询整个表
        FMResultSet *resultSet = [self.db executeQuery:sql];
        //遍历结果集合
        while ([resultSet  next]) {
            [self.db close];
            return YES;
        }
        [self.db close];
    }

    return NO;
}
/**
 *  删除录制表中一条数据
 *
 */
-(BOOL)deleteWithFileID:(NSString *)fileID{
    if ([self OpenDB]) {
        NSString *sql = [NSString stringWithFormat:@"delete from %@ where fileID like '%@'",RecordingTable,fileID];
        //删除一条数据
        BOOL delete = [self.db executeUpdate:sql];
        if (delete) {
            [self.db close];
            return YES;
        }else{
            [self.db close];
            ZQLog(@"删除数据失败");
            return NO;
        }
    }
    return NO;
}
/**
 *  读取录制表的所有数据
 */
-(NSArray *)readAllRecordingModel{

    NSArray *arr = nil;
    if ([self OpenDB]) {
        NSString *sql = [NSString stringWithFormat:@"select * from %@",RecordingTable];
        //查询整个表
        FMResultSet *resultSet = [self.db executeQuery:sql];
        
        
        NSMutableArray *modelArr = [[NSMutableArray alloc] init];
        //遍历结果集合
        
        while ([resultSet  next]) {
            
            NSString *jsonstr = [resultSet stringForColumn:@"data"];
            if (jsonstr) {
                RecordingSQLModel *model = [RecordingSQLModel mj_objectWithKeyValues:jsonstr];
                if (!model.isNeedCover) {
                    [modelArr addObject:model];
                }
                
            }
        }
        //        // 这里的key写的是@property的名称
        //        NSSortDescriptor *dateDesc = [NSSortDescriptor sortDescriptorWithKey:@"pubTime1" ascending:NO];
        //        // 按顺序添加排序描述器
        //        NSArray *descs = [NSArray arrayWithObjects:dateDesc,  nil];
        //        NSArray *array2 = [modelArr sortedArrayUsingDescriptors:descs];
        arr = modelArr;
        [self.db close];
    }
    return arr;
}


-(RecordingSQLModel *)readOneRecordingModelWithFileId:(NSString *)fileId
{
    RecordingSQLModel *molde = nil;
    if ([self OpenDB]) {
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where fileID = '%@'",RecordingTable,fileId];
        //查询整个表
        FMResultSet *resultSet = [self.db executeQuery:sql];
        

        //遍历结果集合
        
        while ([resultSet  next]) {
            
            NSString *jsonstr = [resultSet stringForColumn:@"data"];
            if (jsonstr) {
               molde = [RecordingSQLModel mj_objectWithKeyValues:jsonstr];
                
            }
        }
        //        // 这里的key写的是@property的名称
        //        NSSortDescriptor *dateDesc = [NSSortDescriptor sortDescriptorWithKey:@"pubTime1" ascending:NO];
        //        // 按顺序添加排序描述器
        //        NSArray *descs = [NSArray arrayWithObjects:dateDesc,  nil];
        //        NSArray *array2 = [modelArr sortedArrayUsingDescriptors:descs];
        
        [self.db close];
    }
    return molde;
}
/**
 *  清空录制表的所有数据
 */
-(BOOL)deleteAllRecordingModel{
    if ([self OpenDB]) {
        NSString *sql = [NSString stringWithFormat:@"delete  from %@ ",RecordingTable];
        //删除一条数据
        BOOL delete = [self.db executeUpdate:sql];
        if (delete) {
            ZQLog(@"删除数据成功");
            [self.db close];
            return YES;
        }else{
            [self.db close];
            ZQLog(@"删除数据失败");
            return NO;
        }
        
    }

    return NO;
}
-(void)insertFileWithModelArr:(NSArray *)arr
{
    if (arr.count == 0) {
        return;
    }
    [self deleteAllRecordingModel];
    if ([self OpenDB]) {
        for (int i = 0; i < arr.count; i ++) {
            RecordingSQLModel *model1 = arr[i];
            
            NSDictionary *dic = model1.mj_keyValues;
            NSString *jsonString = [self dicToDataString:dic];
            //插入
            NSString *sql = [NSString stringWithFormat:@"insert into %@(data,fileID,creatDate) values('%@','%@','%@')",RecordingTable,jsonString,model1.fileID,model1.fileCreatDate];
            BOOL insert = [self.db executeUpdate:sql];
            if (insert) {
                ZQLog(@"插入数据成功");
            }else{
                ZQLog(@"插入数据失败");
            }
        }

    }else{
        NSLog(@"数据库打开失败");
    }
        [self.db close];
    

}

@end
