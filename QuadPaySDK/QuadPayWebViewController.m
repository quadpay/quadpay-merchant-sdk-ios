#import "QuadPayWebViewController.h"

@interface QuadPayWebViewController () <WKScriptMessageHandler>

@property (nonatomic, strong, readwrite) WKWebView *webView;

@end

@implementation QuadPayWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
    WKUserContentController *controller = [WKUserContentController new];
    [controller addScriptMessageHandler:self name:@"quadpay"];
    configuration.userContentController = controller;
    configuration.applicationNameForUserAgent = @"QuadPay-iOS-SDK-0001"; // TODO: Version number
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    webView.contentMode = UIViewContentModeScaleAspectFit;
    webView.multipleTouchEnabled = NO;
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    // [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:webView];
    self.webView = webView;
}

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    for(NSString *key in [message.body allKeys]) {
      NSLog(@"%@ %@", key, [message.body objectForKey:key]);
    }
    [self.messageDelegate viewController:self didReceiveScriptMessage:(NSDictionary*)message.body];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (@available(iOS 11.0, *)) {
        [[WKWebsiteDataStore defaultDataStore].httpCookieStore getAllCookies:^(NSArray<NSHTTPCookie *> * cookies) {
            for (NSHTTPCookie *cookie in cookies) {
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
            }
        }];
    }
}

- (void)dealloc
{
    // if (self.webView) {
    //     [self.webView removeObserver:self
    //                       forKeyPath:@"estimatedProgress"
    //                          context:nil];
    // }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
}

- (void)loadErrorPage:(NSError *)error
{
    NSString *errorDescription = [error.localizedDescription stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *url = [NSString stringWithFormat:@"https://www.%@/u/#/error?main=Error&sub=%@", @"QP", errorDescription];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [self loadErrorPage:error];
}

@end
