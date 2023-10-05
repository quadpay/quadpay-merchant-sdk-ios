@class ZipCheckoutViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol ZipMessageReceiverDelegate <NSObject>

- (void)viewController:(UIViewController *)viewController didReceiveScriptMessage:(nonnull NSDictionary *)message;

@end

NS_ASSUME_NONNULL_END
