#import "ZipCardholder.h"
#import "ZipCard.h"
#import "ZipCustomer.h"

@class ZipVirtualCheckoutViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol ZipVirtualCheckoutDelegate <NSObject>

- (void)checkoutSuccessful:(ZipVirtualCheckoutViewController*)viewController card:(ZipCard *)card cardholder:(ZipCardholder *)cardholder customer:(ZipCustomer *)customer orderId:(NSString *)orderId;

- (void)checkoutCancelled:(ZipVirtualCheckoutViewController*)viewController reason:(NSString *)reason;

- (void)didFailWithError:(ZipVirtualCheckoutViewController*)viewController error:(NSString *)error;

@end

NS_ASSUME_NONNULL_END
