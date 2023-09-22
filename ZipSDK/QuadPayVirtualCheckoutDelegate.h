#import "ZipCardholder.h"
#import "ZipCard.h"
#import "QuadPayCustomer.h"

@class QuadPayVirtualCheckoutViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol QuadPayVirtualCheckoutDelegate <NSObject>

- (void)checkoutSuccessful:(QuadPayVirtualCheckoutViewController*)viewController card:(ZipCard *)card cardholder:(ZipCardholder *)cardholder customer:(QuadPayCustomer *)customer orderId:(NSString *)orderId;

- (void)checkoutCancelled:(QuadPayVirtualCheckoutViewController*)viewController reason:(NSString *)reason;

- (void)didFailWithError:(QuadPayVirtualCheckoutViewController*)viewController error:(NSString *)error;

@end

NS_ASSUME_NONNULL_END
