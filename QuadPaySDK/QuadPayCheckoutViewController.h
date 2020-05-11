#import "QuadPayWebViewController.h"
#import "QuadPayCheckoutDelegate.h"

@protocol QuadPayCheckoutDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface QuadPayCheckoutViewController : QuadPayWebViewController

@property (nonatomic, weak) id<QuadPayCheckoutDelegate> delegate;

@property (nonatomic, copy, readonly) NSString *checkoutARI;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                         bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

- (instancetype)initWithDelegate:(id<QuadPayCheckoutDelegate>)delegate
NS_SWIFT_NAME(init(delegate:)) NS_DESIGNATED_INITIALIZER;


+ (QuadPayCheckoutViewController *)startCheckout:(id<QuadPayCheckoutDelegate>)delegate
NS_SWIFT_NAME(start(delegate:));

@end

NS_ASSUME_NONNULL_END
