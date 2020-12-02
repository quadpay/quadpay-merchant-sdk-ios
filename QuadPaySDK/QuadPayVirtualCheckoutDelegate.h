#import "QuadPayCardholder.h"
#import "QuadPayCard.h"
#import "QuadPayCustomer.h"

@class QuadPayVirtualCheckoutViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol QuadPayVirtualCheckoutDelegate <NSObject>

- (void)checkoutSuccessful:(QuadPayVirtualCheckoutViewController*)viewController card:(QuadPayCard *)card cardholder:(QuadPayCardholder *)cardholder customer:(QuadPayCustomer *)customer;

- (void)checkoutCancelled:(QuadPayVirtualCheckoutViewController*)viewController reason:(NSString *)reason;

- (void)didFailWithError:(QuadPayVirtualCheckoutViewController*)viewController error:(NSString *)error;

@end

NS_ASSUME_NONNULL_END
