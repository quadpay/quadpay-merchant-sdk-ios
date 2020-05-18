#import "QuadPay.h"
#import "QuadPayWebViewController.h"
#import "QuadPayVirtualCheckoutDelegate.h"
#import "QuadPayMessageReceiverDelegate.h"
#import "QuadPayCard.h"
#import "QuadPayCardholder.h"
#import "QuadPayCheckoutDetails.h"
#import "QuadPayURLBuilder.h"
#import "ExceptionMessage.h"
#import "VirtualCheckoutSuccessfulMessage.h"
#import "CheckoutCancelledMessage.h"

@protocol QuadPayVirtualCheckoutDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface QuadPayVirtualCheckoutViewController : QuadPayWebViewController <QuadPayMessageReceiverDelegate>

@property (nonatomic, weak) id<QuadPayVirtualCheckoutDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                         bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

- (instancetype)initWithDelegate:(id<QuadPayVirtualCheckoutDelegate>)delegate
NS_SWIFT_NAME(init(delegate:)) NS_DESIGNATED_INITIALIZER;

- (void)setDetails:(QuadPayCheckoutDetails*)newDetails
NS_SWIFT_NAME(setDetails(details:));

+ (QuadPayVirtualCheckoutViewController *)startCheckout:(id<QuadPayVirtualCheckoutDelegate>)delegate details:(QuadPayCheckoutDetails*) details
NS_SWIFT_NAME(start(delegate:details:));

@end

NS_ASSUME_NONNULL_END
