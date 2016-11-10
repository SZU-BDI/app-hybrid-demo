//NOTES: U almost don't need to change this file...

#import <UIKit/UIKit.h>

#import "CMPHybridTools.h"

@interface MyAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

@implementation MyAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // init a UIWindow with "UIScreen->mainScreen()->bounds()":
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // start UiRoot from config...
    [CMPHybridTools startUi:@"UiRoot" strInitParam:nil objCaller:nil callback:nil];
    
    //show the inner UIWindow
    [self.window makeKeyAndVisible];
    
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
