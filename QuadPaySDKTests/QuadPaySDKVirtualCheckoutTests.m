//
//  QuadPaySDKTests.m
//  QuadPaySDKTests
//
//  Copyright © 2020 QuadPay. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QuadPay.h"
#import "QuadPayVirtualCheckoutViewController.h"

@interface QuadPaySDKVirtualCheckoutTests : XCTestCase <QuadPayVirtualCheckoutDelegate> {
    XCTestExpectation *checkoutCancelledWasCalled;
    XCTestExpectation *checkoutSucceededWasCalled;
    XCTestExpectation *didFailWithErrorWasCalled;
    NSString *errorWhenFailed;
    QuadPayVirtualCheckoutViewController *checkoutVC;
}
@end

@implementation QuadPaySDKVirtualCheckoutTests

- (void)setUp {
    [[QuadPay sharedInstance] initialize:@"unitTestMerchantId" environment:@"sandbox" locale:@"US"];

    // Minimum viable calls to start a checkout
    QuadPayCheckoutDetails* details = [QuadPayCheckoutDetails alloc];
    QuadPayVirtualCheckoutViewController* view = [QuadPayVirtualCheckoutViewController startCheckout:self details:details];
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

- (void)test_when_receive_cancelledmessage_should_delegate_cancelled{
    checkoutCancelledWasCalled = [self expectationWithDescription:@"Expect Cancelled Callback"];

    [checkoutVC viewController:checkoutVC didReceiveScriptMessage:@"{\"objectType\":\"userCancelledMessage\"}"];
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertTrue(error == NULL);
    }];
}

- (void)checkoutCancelled:(nonnull QuadPayVirtualCheckoutViewController *)viewController reason:(nonnull NSString *)reason {
    [checkoutCancelledWasCalled fulfill];
}
- (void)checkoutSuccessful:(nonnull QuadPayVirtualCheckoutViewController *)viewController card:(nonnull QuadPayCard *)card cardholder:(nonnull QuadPayCardholder *)cardholder {
    [checkoutSucceededWasCalled fulfill];
}
- (void)didFailWithError:(nonnull QuadPayVirtualCheckoutViewController *)viewController error:(nonnull NSString *)error {
    errorWhenFailed = error;
    [didFailWithErrorWasCalled fulfill];
}

@end
