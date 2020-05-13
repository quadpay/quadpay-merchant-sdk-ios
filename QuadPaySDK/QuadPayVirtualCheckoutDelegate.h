#import "QuadPayCardholder.h"
#import "QuadPayCard.h"

@class QuadPayVirtualCheckoutViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol QuadPayVirtualCheckoutDelegate <NSObject>

- (void)checkoutSuccessful:(QuadPayVirtualCheckoutViewController*)viewController card:(QuadPayCard *)card cardholder:(QuadPayCardholder *)cardholder;

- (void)checkoutCancelled:(QuadPayVirtualCheckoutViewController*)viewController;

- (void)checkoutCancelled:(QuadPayVirtualCheckoutViewController*)viewController reason:(NSString *)reason;

- (void)didFailWithError:(QuadPayVirtualCheckoutViewController*)viewController error:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
