//
//  AppDelegate.m
//  proj-ios-jso-dev
//
//  Created by 双虎 on 16/9/23.
//  Copyright © 2016年 Cmptech. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
//#import "JSODoing.h"
//#import "JSO.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    MainViewController *mainVC = [[MainViewController alloc] init];
    self.window.rootViewController = mainVC;
    [self.window makeKeyAndVisible];
    
//    JSODoing *jsoDoing = [[JSODoing alloc] init];
//    JSO *jso1 = [[JSODictionary alloc] init];
//    JSO *jso2 = [[JSOArray alloc] init];
//    JSO *jso3 = [[JSONumber alloc] init];
//    JSO *jso4 = [[JSOString alloc] init];
//    JSO *jso5 = [[JSONull alloc] init];
//    JSO *jso6 = [[JSOBollean alloc] init];
//    
//    [jsoDoing doTestAction:jso1];
//    [jsoDoing doTestAction:jso2];
//    [jsoDoing doTestAction:jso3];
//    [jsoDoing doTestAction:jso4];
//    [jsoDoing doTestAction:jso5];
//    [jsoDoing doTestAction:jso6];
    
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

@end
