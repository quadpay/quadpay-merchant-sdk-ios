#import "QuadPayWebViewController.h"
#import "QuadPayCheckoutDelegate.h"
#import "QuadPayMessageReceiverDelegate.h"
#import "QuadPayCard.h"
#import "QuadPayCardholder.h"
#import "QuadPayCheckoutDetails.h"
#import "CheckoutSuccessfulMessage.h"
#import "ExceptionMessage.h"
#import "UserCancelledMessage.h"

@protocol QuadPayCheckoutDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface QuadPayCheckoutViewController : QuadPayWebViewController <QuadPayMessageReceiverDelegate>

@property (nonatomic, weak) id<QuadPayCheckoutDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                         bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

- (instancetype)initWithDelegate:(id<QuadPayCheckoutDelegate>)delegate
NS_SWIFT_NAME(init(delegate:)) NS_DESIGNATED_INITIALIZER;


- (void)setDetails:(QuadPayCheckoutDetails*)newDetails
NS_SWIFT_NAME(setDetails(details:));

+ (QuadPayCheckoutViewController *)startCheckout:(id<QuadPayCheckoutDelegate>)delegate details:(QuadPayCheckoutDetails*) details
NS_SWIFT_NAME(start(delegate:details:));

@end

NS_ASSUME_NONNULL_END
