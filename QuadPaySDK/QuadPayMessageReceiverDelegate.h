@class QuadPayCheckoutViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol QuadPayMessageReceiverDelegate <NSObject>

- (void)vc:(QuadPayCheckoutViewController *)vc didReceiveScriptMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
