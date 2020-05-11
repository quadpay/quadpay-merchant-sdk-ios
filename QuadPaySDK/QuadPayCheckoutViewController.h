#import "QuadPayWebViewController.h"
#import "QuadPayCheckoutDelegate.h"

@protocol QuadPayCheckoutDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface QuadPayCheckoutViewController : QuadPayWebViewController

/**
 The delegate which handles checkout events.
 */
@property (nonatomic, weak) id<QuadPayCheckoutDelegate> delegate;

@property (nonatomic, copy, readonly) NSString *checkoutARI;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                         bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

/**
 Initializer. See properties for more details. UseVCN is NO as default

 @param delegate A delegate object which responds to the checkout events created by the view controller.
 @return The newly created checkout view controller.
 */
- (instancetype)initWithDelegate:(id<QuadPayCheckoutDelegate>)delegate
NS_SWIFT_NAME(init(delegate:)) NS_DESIGNATED_INITIALIZER;

/**
 Convenience constructor starts the checkout process and notifies delegate regarding checkout events, useVCN is NO as default

 @param checkout A checkout object which contains information about the customer and the purchase.
 @param delegate A delegate object which responds to the checkout events created by the view controller.
 @return The newly created checkout view controller.
 */
+ (QuadPayCheckoutViewController *)startCheckout:(NSString *)checkout
                                       delegate:(id<QuadPayCheckoutDelegate>)delegate
NS_SWIFT_NAME(start(checkout:delegate:));

@end

NS_ASSUME_NONNULL_END