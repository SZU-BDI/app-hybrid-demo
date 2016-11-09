
#import <Foundation/Foundation.h>

#import "WebViewJavascriptBridgeBase.h"

#import <UIKit/UIWebView.h>


@interface WebViewJavascriptBridge : NSObject<UIWebViewDelegate, WebViewJavascriptBridgeBaseDelegate>

+ (instancetype)bridgeForWebView:(UIWebView *)webView;
+ (void)enableLogging;
+ (void)setLogMaxLength:(int)length;

- (void)registerHandler:(NSString*)handlerName handler:(HybridHandler)handler;
- (void)callHandler:(NSString*)handlerName;
- (void)callHandler:(NSString*)handlerName data:(id)data;
- (void)callHandler:(NSString*)handlerName data:(id)data responseCallback:(HybridCallback)responseCallback;
- (void)setWebViewDelegate:(NSObject<UIWebViewDelegate> *)webViewDelegate;
@end


