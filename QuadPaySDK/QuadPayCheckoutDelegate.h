@class QuadPayCheckoutViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol QuadPayCheckoutDelegate <NSObject>

- (void)checkout:(QuadPayCheckoutViewController *)checkoutViewController completedWithToken:(NSString *)checkoutToken;

- (void)vcnCheckout:(QuadPayCheckoutViewController *)checkoutViewController completedWithCreditCard:(NSString *)creditCard;

- (void)checkoutCancelled:(QuadPayCheckoutViewController *)checkoutViewController;

- (void)checkoutCancelled:(QuadPayCheckoutViewController *)checkoutViewController checkoutCanceledWithReason:(NSString *)reasonCode;

- (void)checkout:(QuadPayCheckoutViewController *)checkoutViewController didFailWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
