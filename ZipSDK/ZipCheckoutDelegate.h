#import "ZipCustomer.h"

@class ZipCheckoutViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol QuadPayCheckoutDelegate <NSObject>

- (void)checkoutSuccessful:(ZipCheckoutViewController*)viewController orderId:(NSString *) orderId customer:(ZipCustomer *) customer;

- (void)checkoutCancelled:(ZipCheckoutViewController*)viewController reason:(NSString *)reason;

- (void)didFailWithError:(ZipCheckoutViewController*)viewController error:(NSString *)error;

@end

NS_ASSUME_NONNULL_END
