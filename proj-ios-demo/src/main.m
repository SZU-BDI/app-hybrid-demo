//NOTES: U almost don't need to change this file...

#import <UIKit/UIKit.h>

#import "CMPHybridTools.h"
#import "JSO.h"

@interface MyAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

@implementation MyAppDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [CMPHybridTools quitGraceFully];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
#ifdef __IPHONE_8_0
    
    // init a UIWindow with "UIScreen->mainScreen()->bounds()":
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // start UiRoot from config...
    [CMPHybridTools startUi:@"UiRoot" strInitParam:nil objCaller:nil callback:nil];
    
    //show the inner UIWindow
    [self.window makeKeyAndVisible];
    
//    [CMPHybridTools quickShowMsgMain:[JSO o2s:[JSO s2o:@"testonly"]]];
//    [CMPHybridTools quickShowMsgMain:[JSO o2s:[JSO s2o:@"{x1:11,x2:22}"]]];
//        NSLog(@" test JSO %@",[[JSO s2o:@"{\"x1\":11,\"x2\":22}"] getChildKeys]);
    NSLog(@" test JSO %@",[[JSO s2o:@"{\"x1\":11,\"x2\":22}"] getChildKeys]);

#else
    
    NSString *ttl=[NSString stringWithFormat:@"iOS (%@) is not supported", [UIDevice currentDevice].systemVersion];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:ttl
                          message:@"" delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK",
                          nil
                          ];
    [alert show];
#endif
    return YES;
}
@end

int main(int argc, char * argv[]) {
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([MyAppDelegate class]));
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
