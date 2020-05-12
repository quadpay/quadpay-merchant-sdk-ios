#import "QuadPayVirtualCheckoutViewController.h"

@interface QuadPayVirtualCheckoutViewController ()

@property (nonatomic, copy, readwrite) NSString *checkoutARI;

@end

@implementation QuadPayVirtualCheckoutViewController

- (instancetype)initWithDelegate:(id<QuadPayVirtualCheckoutDelegate>)delegate
{    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _delegate = delegate;
        self.messageDelegate = self;
    }
    return self;
}

+ (QuadPayVirtualCheckoutViewController *)startCheckout:(nonnull id<QuadPayVirtualCheckoutDelegate>)delegate
{
    return [[self alloc] initWithDelegate:delegate];
}

- (void)vc:(QuadPayVirtualCheckoutViewController *)vc didReceiveScriptMessage:(NSString *)message {
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

        [_delegate checkoutSuccessful:vc card:card cardholder:cardholder];
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

    //NSString* urlString = @"https://safe-badlands-22675.herokuapp.com/";
    NSString* urlString = @"https://master.gateway.quadpay.xyz/virtual?MerchantId=44444444-4444-4444-4444-444444444444&Order.Amount=94.40";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)loadRedirectURL:(NSURL *)redirectURL
{
  [self.webView loadRequest:[NSURLRequest requestWithURL:redirectURL]];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(NO);
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(YES);
                                                      }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [self loadErrorPage:error];
    [self.delegate didFailWithError:self error:error];
}

- (void)webView:(WKWebView *)webView checkIfURL:(NSString *)URLString isPopupWithCompletion:(void(^)(BOOL isPopup))completion
{
    NSString *JSCodeFormat = @"javascript: (function () {"
    "var anchors = document.getElementsByTagName('a');"
    "for (var i = 0; i < anchors.length; i++) {"
    "if (anchors[i].target == '_blank' && anchors[i].href == '%@') {"
    "return true;"
    "}"
    "}"
    "return false;"
    "})();"
    ;
    NSString *JSCode = [NSString stringWithFormat:JSCodeFormat, URLString];
    [webView evaluateJavaScript:JSCode completionHandler:^(id result, NSError *error) {
        completion([result boolValue]);
    }];
}

@end
