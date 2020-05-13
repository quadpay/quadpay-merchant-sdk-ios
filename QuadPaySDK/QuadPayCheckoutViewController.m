#import "QuadPayCheckoutViewController.h"

@interface QuadPayCheckoutViewController ()

@end

@implementation QuadPayCheckoutViewController

- (instancetype)initWithDelegate:(id<QuadPayCheckoutDelegate>)delegate
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _delegate = delegate;
        self.messageDelegate = self;
    }
    return self;
}

+ (QuadPayCheckoutViewController *)startCheckout:(nonnull id<QuadPayCheckoutDelegate>)delegate
{
    return [[self alloc] initWithDelegate:delegate];
}

- (void)viewController:(QuadPayCheckoutViewController *)viewController didReceiveScriptMessage:(NSString *)message {
    NSLog(@"QuadPayCheckoutViewController.didRxScriptMessage: %@", message);
    [_delegate checkoutSuccessful:viewController token:message];
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
    [self.delegate didFailWithError:self error:error];
}

@end
