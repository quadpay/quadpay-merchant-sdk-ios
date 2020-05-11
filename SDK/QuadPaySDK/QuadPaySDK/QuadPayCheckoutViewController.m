#import "QuadPayCheckoutViewController.h"

@interface QuadPayCheckoutViewController ()

@property (nonatomic, copy, readwrite) NSString *checkoutARI;

@end

@implementation QuadPayCheckoutViewController

- (instancetype)initWithDelegate:(id<QuadPayCheckoutDelegate>)delegate
{    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _delegate = delegate;
    }
    return self;
}

+ (QuadPayCheckoutViewController *)startCheckout:(NSString *)checkout
                                       delegate:(nonnull id<QuadPayCheckoutDelegate>)delegate
{
    return [[self alloc] initWithDelegate:delegate
                                 checkout:checkout
                                   useVCN:NO
                           getReasonCodes:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(dismiss)];
}

- (void)loadRedirectURL:(NSURL *)redirectURL
{
  [self.webView loadRequest:[NSURLRequest requestWithURL:redirectURL]];
}

#pragma mark - Webview

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
    [self.delegate checkout:self didFailWithError:error];
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