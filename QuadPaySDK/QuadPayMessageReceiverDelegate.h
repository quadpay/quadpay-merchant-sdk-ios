@class QuadPayCheckoutViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol QuadPayMessageReceiverDelegate <NSObject>

- (void)viewController:(UIViewController *)viewController didReceiveScriptMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
