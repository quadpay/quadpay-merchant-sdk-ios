#import "Zip.h"
#import "QuadPayWebViewController.h"
#import "QuadPayVirtualCheckoutDelegate.h"
#import "ZipMessageReceiverDelegate.h"
#import "ZipCard.h"
#import "ZipCardholder.h"
#import "ZipCheckoutDetails.h"
#import "QuadPayURLBuilder.h"
#import "ExceptionMessage.h"
#import "VirtualCheckoutSuccessfulMessage.h"
#import "CheckoutCancelledMessage.h"

@protocol QuadPayVirtualCheckoutDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface QuadPayVirtualCheckoutViewController : QuadPayWebViewController <ZipMessageReceiverDelegate>

@property (nonatomic, weak) id<QuadPayVirtualCheckoutDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                         bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

- (instancetype)initWithDelegate:(id<QuadPayVirtualCheckoutDelegate>)delegate
NS_SWIFT_NAME(init(delegate:)) NS_DESIGNATED_INITIALIZER;

- (void)setDetails:(ZipCheckoutDetails*)newDetails
NS_SWIFT_NAME(setDetails(details:));

+ (QuadPayVirtualCheckoutViewController *)startCheckout:(id<QuadPayVirtualCheckoutDelegate>)delegate details:(ZipCheckoutDetails*) details
NS_SWIFT_NAME(start(delegate:details:));

@end

NS_ASSUME_NONNULL_END
