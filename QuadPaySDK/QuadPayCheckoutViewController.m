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

    NSString* urlString = [QuadPayURLBuilder buildCheckoutURL:details];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)viewController:(UIViewController *)viewController didReceiveScriptMessage:(nonnull NSDictionary *)message {
    NSString* messageType = [message objectForKey:@"messageType"];

    // It's JSON but not a QP message
    if (messageType == NULL) {
        [self->_delegate didFailWithError:self error:@"Received non-QP message"];
        return;
    }
    
    // Code blocks to handle each message type - decode message and delegate to handler
    typedef void (^CaseBlock)(void);
    NSDictionary *messageBlocks = @{
        @"CheckoutCancelledMessage": ^{
            CheckoutCancelledMessage* quadpayMessage = [[CheckoutCancelledMessage alloc] initWithDict:message];
            [self->_delegate checkoutCancelled:self reason:quadpayMessage.reason];
        },
        @"CheckoutSuccessfulMessage": ^{
            CheckoutSuccessfulMessage* quadpayMessage = [[CheckoutSuccessfulMessage alloc] initWithDict:message];
            [self->_delegate checkoutSuccessful:self orderId:quadpayMessage.orderId customer:quadpayMessage.customer];
        },
        @"ExceptionMessage": ^{
            ExceptionMessage* quadpayMessage = [[ExceptionMessage alloc] initWithDict:message];
            [self->_delegate didFailWithError:self error:quadpayMessage.message];
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

//window.open needs this configuration to work.
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
  if (navigationAction.request.URL) {
      NSLog(@"%@", navigationAction.request.URL.host);
      if (![navigationAction.request.URL.resourceSpecifier containsString:@"ex path"]) {
          if ([[UIApplication sharedApplication] canOpenURL:navigationAction.request.URL]) {
              UIApplication *application = [UIApplication sharedApplication];
              [application openURL:navigationAction.request.URL options:@{} completionHandler:nil];
          }
      }
  }
  return nil;
}

// href need this configuration to work
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(nonnull WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler {
if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
    if (navigationAction.request.URL) {
        NSLog(@"%@", navigationAction.request.URL.host);
        if (![navigationAction.request.URL.resourceSpecifier containsString:@"ex path"]) {
            if ([[UIApplication sharedApplication] canOpenURL:navigationAction.request.URL]) {
                UIApplication *application = [UIApplication sharedApplication];
                [application openURL:navigationAction.request.URL options:@{} completionHandler:nil];
                decisionHandler(WKNavigationActionPolicyCancel);
            }
        } else {
            decisionHandler(WKNavigationActionPolicyAllow);
        }
    }
} else {
    decisionHandler(WKNavigationActionPolicyAllow);
}
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    if ([navigationResponse.response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse * response = (NSHTTPURLResponse *)navigationResponse.response;
        if (response.statusCode != 200) {
            decisionHandler(WKNavigationResponsePolicyCancel);
        } else {
            decisionHandler(WKNavigationResponsePolicyAllow);
        }
    } else {
        decisionHandler(WKNavigationResponsePolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [self loadErrorPage:error];
    [self.delegate didFailWithError:self error:[error description]];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;
{
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    if (error) {
        NSString* errorMessage = [NSString stringWithFormat:@"WebView.didFailProvisionalNavigation %@", [error localizedDescription]];
        [self.delegate didFailWithError:self error:errorMessage];
    } else {
        [self.delegate didFailWithError:self error:@"QuadPay webview failed to load."];
    }
}

@end
