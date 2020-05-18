#import "QuadPayCheckoutViewController.h"

@interface QuadPayCheckoutViewController ()

@end

@implementation QuadPayCheckoutViewController {
    QuadPayCheckoutDetails* details;
}

- (instancetype)initWithDelegate:(id<QuadPayCheckoutDelegate>)delegate
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _delegate = delegate;
        self.messageDelegate = self;
    }
    return self;
}

+ (QuadPayCheckoutViewController *)startCheckout:(id<QuadPayCheckoutDelegate>)delegate details:(QuadPayCheckoutDetails *)details {
    QuadPayCheckoutViewController* vc = [[self alloc] initWithDelegate:delegate];
    [vc setDetails:details];
    return vc;
}

- (void)setDetails:(QuadPayCheckoutDetails *)newDetails {
    details = newDetails;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(dismiss)];

    //NSString* urlString = @"https://safe-badlands-22675.herokuapp.com/";
    NSString* urlString = @"https://master.gateway.quadpay.xyz/virtual?MerchantId=44444444-4444-4444-4444-444444444444&Order.Amount=94.40";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)viewController:(UIViewController *)viewController didReceiveScriptMessage:(NSString *)message {
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id jsonOutput = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

    // Could not decode message...
    if (jsonOutput == NULL || error != NULL) {
        [self->_delegate didFailWithError:self error:@"Received non-JSON message"];
        return;
    }

    NSString* messageType = [jsonOutput objectForKey:@"objectType"];

    // It's JSON but not a QP message
    if (messageType == NULL) {
        [self->_delegate didFailWithError:self error:@"Received non-QP message"];
        return;
    }
    
    // Code blocks to handle each message type - decode message and delegate to handler
    typedef void (^CaseBlock)(void);
    NSDictionary *messageBlocks = @{
        @"UserCancelledMessage": ^{
            UserCancelledMessage* message = [[UserCancelledMessage alloc] initWithDict:jsonOutput];
            [self->_delegate checkoutCancelled:self reason:message.reason];
        },
        @"CheckoutSuccessfulMessage": ^{
            CheckoutSuccessfulMessage* message = [[CheckoutSuccessfulMessage alloc] initWithDict:jsonOutput];
            [self->_delegate checkoutSuccessful:self token:message.token];
        },
        @"ExceptionMessage": ^{
            ExceptionMessage* message = [[ExceptionMessage alloc] initWithDict:jsonOutput];
            [self->_delegate didFailWithError:self error:message.message];
        }
    };
    
    // Call the chosen block -- wrapped in t/c to handle any decoding or delegation errors
    CaseBlock block = messageBlocks[messageType];
    if (block) {
        @try {
            block();
        }
        @catch(NSException* e) {
            [self->_delegate didFailWithError:self error:[e description]];
        }
    } else {
        // It looks like a QP message but we can't figure out which type
        [self->_delegate didFailWithError:self error:@"Could not interpret QPMessage"];
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [self loadErrorPage:error];
    [self.delegate didFailWithError:self error:[error description]];
}

@end
