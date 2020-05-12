#import "QuadPayWebViewController.h"
#import "QuadPayVirtualCheckoutDelegate.h"
#import "QuadPayMessageReceiverDelegate.h"
#import "QuadPayCard.h"
#import "QuadPayCardholder.h"

@protocol QuadPayVirtualCheckoutDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface QuadPayVirtualCheckoutViewController : QuadPayWebViewController <QuadPayMessageReceiverDelegate>

@property (nonatomic, weak) id<QuadPayVirtualCheckoutDelegate> delegate;

@property (nonatomic, copy, readonly) NSString *checkoutARI;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                         bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

- (instancetype)initWithDelegate:(id<QuadPayVirtualCheckoutDelegate>)delegate
NS_SWIFT_NAME(init(delegate:)) NS_DESIGNATED_INITIALIZER;


+ (QuadPayVirtualCheckoutViewController *)startCheckout:(id<QuadPayVirtualCheckoutDelegate>)delegate
NS_SWIFT_NAME(start(delegate:));

@end

NS_ASSUME_NONNULL_END
