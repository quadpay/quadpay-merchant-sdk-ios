#import "QuadPayWebViewController.h"
#import "ZipCheckoutDelegate.h"
#import "ZipMessageReceiverDelegate.h"
#import "ZipCard.h"
#import "ZipCardholder.h"
#import "ZipCheckoutDetails.h"
#import "CheckoutSuccessfulMessage.h"
#import "ExceptionMessage.h"
#import "CheckoutCancelledMessage.h"
#import "QuadPayURLBuilder.h"

@protocol QuadPayCheckoutDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface ZipCheckoutViewController : QuadPayWebViewController <ZipMessageReceiverDelegate>

@property (nonatomic, weak) id<QuadPayCheckoutDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                         bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

- (instancetype)initWithDelegate:(id<QuadPayCheckoutDelegate>)delegate
NS_SWIFT_NAME(init(delegate:)) NS_DESIGNATED_INITIALIZER;


- (void)setDetails:(ZipCheckoutDetails*)newDetails
NS_SWIFT_NAME(setDetails(details:));

+ (ZipCheckoutViewController *)startCheckout:(id<QuadPayCheckoutDelegate>)delegate details:(ZipCheckoutDetails*) details
NS_SWIFT_NAME(start(delegate:details:));

@end

NS_ASSUME_NONNULL_END
