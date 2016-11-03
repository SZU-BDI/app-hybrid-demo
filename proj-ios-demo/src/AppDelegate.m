//
//  AppDelegate.m
//  testproj-ios-core
//
//  Created by 双虎 on 16/6/2.
//  Copyright © 2016年 Cmptech. All rights reserved.
//

#import "AppDelegate.h"
#import "HybridTools.h"
#import "HybridUi.h"
#import "JSO.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // get config.json form HybridTools
    [HybridTools initAppConfig];
    
    // initial the app window:
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // start UiRoot
    [HybridTools startUi:@"UiRoot" strInitParam:nil objCaller:nil callback:nil];
    
    // show the window:
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//- (void)getAppConfig{
//
//    // 检查app是否为首次安装或者升级
//    [self installationAndUpgradeForTheFirstTime];
//
//    // 获取文件(config.json)的路径
//    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"config"ofType:@"json"];
//    // 读取数据
//    NSData *jsonData = [[NSData alloc]initWithContentsOfFile:filePath];
//    // 把json数据转换成Dictionary
//    NSError *error;
//    NSDictionary *jsonContent = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
//
//    // 若配置没有缓存，则缓存
//    if (![self determineWhetherTheCacheConfiguration]) {
//        NSLog(@"配置缓存不存在，做缓存。");
//        // 持久化获取的配置，以config为key （）
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        [userDefaults setObject:jsonContent forKey:@"config"];
//        [userDefaults synchronize];
//    }
//}
//
//- (void)installationAndUpgradeForTheFirstTime{
//
//    // 获取当前版本号
//    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//    // 获取储存的最后版本号
//    NSString *finalVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"finalVersion"];
//
//    if (![currentVersion isEqualToString:finalVersion]) {
//        NSLog(@"App重新安装或者升级，如果配置缓存存在，则删除");
//        if ([self determineWhetherTheCacheConfiguration]) {
//            NSLog(@"检查发现配置缓存存在 --> 删除配置");
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            [userDefaults removeObjectForKey:@"config"];
//            [userDefaults synchronize];
//        }
//    }
//
//    // 存储当前版本号为最后的版本号。
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:currentVersion forKey:@"finalVersion"];
//    [userDefaults synchronize];
//
//}
//
//- (BOOL)determineWhetherTheCacheConfiguration{
//
//    NSDictionary *appConfig = [[NSUserDefaults standardUserDefaults] objectForKey:@"config"];
//    if (appConfig) {
//        return YES;
//    }else{
//        return NO;
//    }
//}
@end
