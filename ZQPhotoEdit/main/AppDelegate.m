//
//  AppDelegate.m
//  ZQPhotoEdit
//
//  Created by 肖兆强 on 2017/11/8.
//  Copyright © 2017年 ZQDemo. All rights reserved.
//

#import "AppDelegate.h"
#import "ZQPhotoListController.h"
#import "SqliteControl+Recording.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ZQPhotoListController alloc]init]];
    
    self.window = window;
    [self.window makeKeyAndVisible];
    [self initImagePath];
    [self initSqlieTable];
    
    
    return YES;
}

-(BOOL)initImagePath
{
    NSString *path = ImageDir;
    BOOL isDir;
    if(![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]){
        if([[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil]){
            return YES;
        }else{
            ZQLog(@"图片路径创建失败！！！");
            return NO;
        }
    }
    return YES;
}

-(void)initSqlieTable
{
    SqliteControl *control = [SqliteControl shareControl];
   
    if(![control isTableExit:RecordingTable]){
        [control creatRecordingModelTable];
    }else{
        
    }
    
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
