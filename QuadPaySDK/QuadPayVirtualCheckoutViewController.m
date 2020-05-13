#import "QuadPayVirtualCheckoutViewController.h"

@interface QuadPayVirtualCheckoutViewController ()

@end

@implementation QuadPayVirtualCheckoutViewController

QuadPayCheckoutDetails* details;

- (instancetype)initWithDelegate:(id<QuadPayVirtualCheckoutDelegate>)delegate
{    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _delegate = delegate;
        self.messageDelegate = self;
    }
    return self;
}

+ (QuadPayVirtualCheckoutViewController *)startCheckout:(id<QuadPayVirtualCheckoutDelegate>)delegate details:(QuadPayCheckoutDetails *)details {
    QuadPayVirtualCheckoutViewController* vc = [[self alloc] initWithDelegate:delegate];
    [vc setDetails:details];
    return vc;
}

- (void)setDetails:(QuadPayCheckoutDetails *)newDetails {
    details = newDetails;
}

- (void)viewController:(UIViewController *)viewController didReceiveScriptMessage:(NSString *)message {
    NSLog(@"QuadPayVirtualCheckoutViewController.didRxScriptMessage: %@", message);
    // TODO: Decoding logic
    if ([message isEqualToString:@"User Cancelled"]) {
        [_delegate checkoutCancelled:self reason:message];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
        id jsonOutput = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", jsonOutput);
        
        QuadPayCard* card = [[QuadPayCard alloc] initWithDict:jsonOutput];
        QuadPayCardholder* cardholder = [[QuadPayCardholder alloc] initWithDict: jsonOutput];

        [_delegate checkoutSuccessful:(QuadPayVirtualCheckoutViewController*)viewController card:card cardholder:cardholder];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(dismiss)];
    NSString* urlString = [self createVirtualCheckoutURL];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (NSString *)createVirtualCheckoutURL {
    if (details == NULL) {
        @throw [NSException exceptionWithName:@"DetailsNullException" reason:@"Checkout details cannot be null" userInfo:NULL];
    }
    NSString * base = [NSString stringWithFormat:@"https://master.gateway.quadpay.xyz/virtual?MerchantId=44444444-4444-4444-4444-444444444444&Order.Amount=%@", details.amount];

    if (details.merchantReference) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&merchantReference=%@", details.merchantReference]];
    }
    if (details.customerEmail) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&Order.Email=%@", details.customerEmail]];
    }
    if (details.customerFirstName) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&Order.FirstName=%@", details.customerFirstName]];
    }
    if (details.customerLastName) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&Order.LastName=%@", details.customerLastName]];
    }
    if (details.customerPhoneNumber) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&Order.Phone=%@", details.customerPhoneNumber]];
    }
    if (details.customerAddressLine1) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&Order.BillingAddress.Line1=%@", details.customerAddressLine1]];
    }
    if (details.customerAddressLine2) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&Order.BillingAddress.Line2=%@", details.customerAddressLine2]];
    }
    if (details.customerCity) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&Order.BillingAddress.City=%@", details.customerCity]];
    }
    if (details.customerState) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&Order.BillingAddress.State=%@", details.customerState]];
    }
    if (details.customerPostalCode) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&Order.BillingAddress.PostalCode=%@", details.customerPostalCode]];
    }
    if (details.customerCountry) {
        base = [base stringByAppendingString:[NSString stringWithFormat:@"&Order.BillingAddress.Country=%@", details.customerCountry]];
    }
    return base;
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
