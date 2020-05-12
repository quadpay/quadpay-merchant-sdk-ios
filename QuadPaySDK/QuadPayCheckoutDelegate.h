@class QuadPayCheckoutViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol QuadPayCheckoutDelegate <NSObject>

- (void)checkoutSuccessful:(QuadPayCheckoutViewController*)viewController token:(NSString *) token;

- (void)checkoutCancelled:(QuadPayCheckoutViewController*)viewController;

- (void)checkoutCancelled:(QuadPayCheckoutViewController*)viewController reason:(NSString *)reason;

- (void)didFailWithError:(QuadPayCheckoutViewController*)viewController error:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
