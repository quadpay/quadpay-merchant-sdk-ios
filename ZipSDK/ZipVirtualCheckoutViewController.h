#import "Zip.h"
#import "ZipWebViewController.h"
#import "ZipVirtualCheckoutDelegate.h"
#import "ZipMessageReceiverDelegate.h"
#import "ZipCard.h"
#import "ZipCardholder.h"
#import "ZipCheckoutDetails.h"
#import "ZipURLBuilder.h"
#import "ExceptionMessage.h"
#import "VirtualCheckoutSuccessfulMessage.h"
#import "CheckoutCancelledMessage.h"

@protocol ZipVirtualCheckoutDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface ZipVirtualCheckoutViewController : ZipWebViewController <ZipMessageReceiverDelegate>

@property (nonatomic, weak) id<ZipVirtualCheckoutDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                         bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

- (instancetype)initWithDelegate:(id<ZipVirtualCheckoutDelegate>)delegate
NS_SWIFT_NAME(init(delegate:)) NS_DESIGNATED_INITIALIZER;

- (void)setDetails:(ZipCheckoutDetails*)newDetails
NS_SWIFT_NAME(setDetails(details:));

+ (ZipVirtualCheckoutViewController *)startCheckout:(id<ZipVirtualCheckoutDelegate>)delegate details:(ZipCheckoutDetails*) details
NS_SWIFT_NAME(start(delegate:details:));

@end

NS_ASSUME_NONNULL_END
