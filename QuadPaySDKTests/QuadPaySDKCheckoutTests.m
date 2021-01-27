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
    NSString *orderIdReceived;
    QuadPayCheckoutViewController *checkoutVC;
}
@end

@implementation QuadPaySDKCheckoutTests

- (void)setUp {
    [[QuadPay sharedInstance] initialize:@"5898b9a9-46bb-4647-92ed-52643d019d8c" environment:@"sandbox" locale:@"US"];

    // Minimum viable calls to start a checkout
    QuadPayCheckoutDetails* details = [QuadPayCheckoutDetails alloc];
    [details setAmount:[NSDecimalNumber decimalNumberWithString:@"100"]];
    QuadPayCheckoutViewController* view = [QuadPayCheckoutViewController startCheckout:self details:details];
    XCTAssertTrue(view != NULL);

    // Cause WebView to init and base urls to be opened and tested
    [view viewDidLoad];

    checkoutVC = view;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)test_when_receive_exceptionmessage_should_delegate_failure{
    didFailWithErrorWasCalled = [self expectationWithDescription:@"Expect DidFail Callback"];

    NSDictionary* message = @{
        @"messageType": @"ExceptionMessage",
        @"signature": @"asdfasdf",
        @"message": @{
                @"message": @"An internal error has occurred",
        }
    };
    
    [checkoutVC viewController:checkoutVC didReceiveScriptMessage:message];
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertTrue(error == NULL);
    }];
    XCTAssertTrue([errorWhenFailed isEqualToString:@"An internal error has occurred"]);
}

- (void)test_when_receive_cancelledmessage_should_delegate_cancelled{
    checkoutCancelledWasCalled = [self expectationWithDescription:@"Expect Cancelled Callback"];

    NSDictionary* message = @{
        @"messageType": @"CheckoutCancelledMessage",
        @"signature": @"asdfasdf",
        @"message": @{
                @"reason": @"closed",
        }
    };
    
    [checkoutVC viewController:checkoutVC didReceiveScriptMessage:message];
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertTrue(error == NULL);
    }];
}

- (void)test_when_receive_success_should_have_token{
    checkoutSucceededWasCalled = [self expectationWithDescription:@"Expect Success Callback"];

    NSDictionary* message = @{
        @"messageType": @"CheckoutSuccessfulMessage",
        @"signature": @"asdfasdf",
        @"message": @{
                @"orderId": @"test-order-id-1234",
                @"customer": @{
                    @"firstName": @"Juliette",
                    @"lastName": @"Quadrilateral",
                    @"address1": @"240 Meeker Ave",
                    @"address2": @"Apt 35",
                    @"city": @"New York",
                    @"state": @"NY",
                    @"postalCode": @"11211",
                    @"country": @"US",
                    @"email": @"sdk_test@quadpay.com",
                    @"phoneNumber": @"+1231231234",
                }
        }
    };

    [checkoutVC viewController:checkoutVC didReceiveScriptMessage:message];
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertTrue(error == NULL);
        XCTAssertTrue([self->orderIdReceived isEqualToString:@"test-order-id-1234"]);
    }];
}

- (void)test_when_receive_badmessage_should_delegate_failure{
    didFailWithErrorWasCalled = [self expectationWithDescription:@"Expect Failure Callback"];

    NSDictionary* message = @{
        @"messageType": @"CheckoutSuccessfulMessage",
        @"signature": @"asdfasdf",
        @"message": @{
                @"torken": @"testToken",
        }
    };

    [checkoutVC viewController:checkoutVC didReceiveScriptMessage:message];
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertTrue(error == NULL);
    }];
}

- (void)test_when_receive_unsignedmessage_should_delegate_failure{
    didFailWithErrorWasCalled = [self expectationWithDescription:@"Expect Failure Callback"];

    NSDictionary* message = @{
        @"messageType": @"CheckoutSuccessfulMessage",
        @"message": @{
                @"token": @"testToken",
        }
    };

    [checkoutVC viewController:checkoutVC didReceiveScriptMessage:message];
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertTrue(error == NULL);
    }];
}

- (void)checkoutCancelled:(nonnull QuadPayCheckoutViewController *)viewController reason:(nonnull NSString *)reason {
    [checkoutCancelledWasCalled fulfill];
}
- (void)checkoutSuccessful:(nonnull QuadPayCheckoutViewController *)viewController orderId:(NSString *)orderId customer:(QuadPayCustomer *)customer {
    orderIdReceived = orderId;
    [checkoutSucceededWasCalled fulfill];
}
- (void)didFailWithError:(nonnull QuadPayCheckoutViewController *)viewController error:(nonnull NSString *)error {
    errorWhenFailed = error;
    [didFailWithErrorWasCalled fulfill];
    // Fulfill and remove. Subsequent messages to nil are ignored.
    didFailWithErrorWasCalled = nil;
}

@end
