@class QuadPayCheckoutViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol QuadPayCheckoutDelegate <NSObject>

- (void)checkoutSuccessful:(QuadPayCheckoutViewController*)viewController orderId:(NSString *) orderId;

- (void)checkoutCancelled:(QuadPayCheckoutViewController*)viewController reason:(NSString *)reason;

- (void)didFailWithError:(QuadPayCheckoutViewController*)viewController error:(NSString *)error;

@end

NS_ASSUME_NONNULL_END
