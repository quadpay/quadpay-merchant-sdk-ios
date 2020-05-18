//
//  QuadPaySDKTests.m
//  QuadPaySDKTests
//
//  Copyright © 2020 QuadPay. All rights reserved.
//
#import <XCTest/XCTest.h>
#import "QuadPay.h"
#import "QuadPayCheckoutViewController.h"

@interface QuadPaySDKCheckoutTests : XCTestCase <QuadPayCheckoutDelegate> {
    XCTestExpectation *checkoutCancelledWasCalled;
    XCTestExpectation *checkoutSucceededWasCalled;
    XCTestExpectation *didFailWithErrorWasCalled;
    NSString *errorWhenFailed;
    NSString *tokenReceived;
    QuadPayCheckoutViewController *checkoutVC;
}
@end

@implementation QuadPaySDKCheckoutTests

- (void)setUp {
    [[QuadPay sharedInstance] initialize:@"unitTestMerchantId" environment:@"sandbox" locale:@"US"];

    // Minimum viable calls to start a checkout
    QuadPayCheckoutDetails* details = [QuadPayCheckoutDetails alloc];
    QuadPayCheckoutViewController* view = [QuadPayCheckoutViewController startCheckout:self details:details];
    XCTAssertTrue(view != NULL);

    // Cause WebView to init and base urls to be opened and tested
    [view viewDidLoad];

    checkoutVC = view;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)test_when_nonJSONmessage_should_delegate_failure{
    didFailWithErrorWasCalled = [self expectationWithDescription:@"Expect DidFail Callback"];
    [checkoutVC viewController:checkoutVC didReceiveScriptMessage:@"User Cancelled"];
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertTrue(error == NULL);
    }];
    XCTAssertTrue([errorWhenFailed isEqualToString:@"Received non-JSON message"]);
}

- (void)test_when_receive_nonQPmessage_should_delegate_failure{
    didFailWithErrorWasCalled = [self expectationWithDescription:@"Expect DidFail Callback"];

    [checkoutVC viewController:checkoutVC didReceiveScriptMessage:@"{\"obj\":\"type\"}"];
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertTrue(error == NULL);
    }];
    XCTAssertTrue([errorWhenFailed isEqualToString:@"Received non-QP message"]);
}

- (void)test_when_receive_exceptionmessage_should_delegate_failure{
    didFailWithErrorWasCalled = [self expectationWithDescription:@"Expect DidFail Callback"];

    [checkoutVC viewController:checkoutVC didReceiveScriptMessage:@"{\"objectType\":\"ExceptionMessage\",\"message\":\"An internal error has occurred\"}"];
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertTrue(error == NULL);
    }];
    XCTAssertTrue([errorWhenFailed isEqualToString:@"An internal error has occurred"]);
}

- (void)test_when_receive_cancelledmessage_should_delegate_cancelled{
    checkoutCancelledWasCalled = [self expectationWithDescription:@"Expect Cancelled Callback"];

    [checkoutVC viewController:checkoutVC didReceiveScriptMessage:@"{\"objectType\":\"UserCancelledMessage\",\"reason\":\"closed\"}"];
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertTrue(error == NULL);
    }];
}

- (void)test_when_receive_success_should_have_token{
    checkoutSucceededWasCalled = [self expectationWithDescription:@"Expect Success Callback"];

    [checkoutVC viewController:checkoutVC didReceiveScriptMessage:@"{\"objectType\":\"CheckoutSuccessfulMessage\",\"token\":\"testToken\"}"];
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertTrue(error == NULL);
        XCTAssertTrue([self->tokenReceived isEqualToString:@"testToken"]);
    }];
}

- (void)test_when_receive_badmessage_should_delegate_failure{
    didFailWithErrorWasCalled = [self expectationWithDescription:@"Expect Failure Callback"];

    [checkoutVC viewController:checkoutVC didReceiveScriptMessage:@"{\"objectType\":\"CheckoutSuccessfulMessage\",\"torken\":\"testToken\"}"];
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertTrue(error == NULL);
    }];
}

- (void)checkoutCancelled:(nonnull QuadPayCheckoutViewController *)viewController reason:(nonnull NSString *)reason {
    [checkoutCancelledWasCalled fulfill];
}
- (void)checkoutSuccessful:(nonnull QuadPayCheckoutViewController *)viewController token:(NSString*)token {
    tokenReceived = token;
    [checkoutSucceededWasCalled fulfill];
}
- (void)didFailWithError:(nonnull QuadPayCheckoutViewController *)viewController error:(nonnull NSString *)error {
    errorWhenFailed = error;
    [didFailWithErrorWasCalled fulfill];
}

@end
