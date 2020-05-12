#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

#import <QuadPayMessageReceiverDelegate.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuadPayWebViewController : UIViewController <WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong, readonly) WKWebView *webView;
@property (nonatomic, weak) id<QuadPayMessageReceiverDelegate> messageDelegate;

- (void)loadErrorPage:(NSError *)error;

- (void)dismiss;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
