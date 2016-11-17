//NOTES: U almost don't need to change this file...

#import <UIKit/UIKit.h>

#import "CMPHybridTools.h"
#import "JSO.h"


void uncaughtExceptionHandler(NSException *exception)
{
    NSLog(@"App Crash:\n%@", exception);
    NSLog(@"Stack Trace:\n%@", [exception callStackSymbols]);
    [CMPHybridTools
     quickAlertMsg:[exception reason]
     callback:^{
         [CMPHybridTools quitGracefully];
     }];
}

@interface MyAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

@implementation MyAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    //NSLog(@"TEST JSO %@", [[JSO s2o:@"\"xx  \n\"s"] toString :YES]);
//    JSO * j1=[JSO id2o:@[@1,@2]];
//    JSO * j2=[JSO id2o:@{@"x":@{}}];
//    JSO * j3=[JSO id2o:@{@"y":@[@"31",@33]}];
//    JSO * j5=[[[j2 basicMerge:j1] basicMerge:j3] basicMerge:nil];
//    NSLog(@"j3= %@ ",[j5 toString]);
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    NSString * minVer=@"8.0";
    
    NSComparisonResult order = [[UIDevice currentDevice].systemVersion compare:minVer options: NSNumericSearch];
    if (  (order == NSOrderedSame || order == NSOrderedDescending)) {
        //>=minVer
        
        // init a UIWindow with "UIScreen->mainScreen()->bounds()":
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

        // start UiRoot from config...
        CMPHybridUi *ui=[CMPHybridTools startUi:@"UiRoot" initData:nil objCaller:nil];
        //    callback:^(id responseData){
        //        NSLog(@"on startUi callback %@",responseData);
        //    }
        if(ui!=nil){
            [ui on:@"close" :^(NSString *eventName, id extraData){
                //responseCallback(extraData);
                NSLog(@" ui trigger close but no responseCallback here...");
            }];
        }
        [self.window makeKeyAndVisible];
    } else {
        //<minVer
        
        [CMPHybridTools
         quickAlertMsg:[NSString stringWithFormat:@"iOS (%@) is not supported", [UIDevice currentDevice].systemVersion]
         callback:^{
             [CMPHybridTools quitGracefully];
         }];
    }
    
    return YES;
}
@end


int main(int argc, char * argv[]) {
    
    @autoreleasepool {
        @try {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([MyAppDelegate class]));
        }
        @catch (NSException *exception) {
            NSLog(@"main: %@", exception);
            NSLog(@"main trace: %@", [exception callStackSymbols]);
            //            [CMPHybridTools
            //             quickAlertMsg:[exception reason]
            //             callback:^{
            //                 [CMPHybridTools quitGracefully];
            //             }];
            //main(argc,argv);//haha, don't!
        }
    }
}

/* NOTES
 
 see Info.plist for the storyboard (story-baoard is new way onto the launch screen)
 <key>UILaunchStoryboardName</key>
	<string>MyLaunchStoryBoard</string>
 
 */
/* TEMPLATE_1($AppName)
 
 #import <UIKit/UIKit.h>
 #import "{$AppName}AppDelegate.h"
 int main(int argc, char *argv[])
 {
 int retVal;
 
 @autoreleasepool {
 @try {
 retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([{$AppName}AppDelegate class]));
 }
 @catch (NSException *exception) {
 NSLog(@"CRASH: %@", exception);
 NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
 
 }
 }
 
 return retVal;
 }
 */
