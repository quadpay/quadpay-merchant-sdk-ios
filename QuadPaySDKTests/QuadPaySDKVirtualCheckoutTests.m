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

- (NSString*) dictToJson:(NSDictionary*)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
};

- (void)setUp {
    [[QuadPay sharedInstance] initialize:@"5898b9a9-46bb-4647-92ed-52643d019d8c" environment:@"sandbox" locale:@"US"];

    // Minimum viable calls to start a checkout
    QuadPayCheckoutDetails* details = [QuadPayCheckoutDetails alloc];
    [details setAmount:[NSDecimalNumber decimalNumberWithString:@"100"]];
    QuadPayVirtualCheckoutViewController* view = [QuadPayVirtualCheckoutViewController startCheckout:self details:details];
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
        @"message": @{
                @"reason": @"No reason at all!",
        }
    };
    
    [checkoutVC viewController:checkoutVC didReceiveScriptMessage:message];
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertTrue(error == NULL);
    }];
}

- (void)test_when_receive_success_message_should_delegate_success{
    checkoutSucceededWasCalled = [self expectationWithDescription:@"Expect Success Callback"];

    NSDictionary* message = @{
        @"messageType": @"VirtualCheckoutSuccessfulMessage",
        @"message": @{
                @"card": @{
                        @"number": @"1234123412341234",
                        @"cvc": @"112",
                        @"expirationMonth": @11,
                        @"expirationYear": @2022,
                        @"brand": @"Visa"
                },
                @"cardholder": @{
                        @"name": @"QuadPay",
                        @"address1": @"123 any street",
                        @"city": @"New York",
                        @"state": @"NY",
                        @"postalCode": @"11001",
                        @"country": @"US"
                },
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
                @"orderId": @"19d1228b-a022-456a-a927-102b39b96e54"
        }
    };

    [checkoutVC viewController:checkoutVC didReceiveScriptMessage:message];
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertTrue(error == NULL);
    }];
}

- (void)test_when_receive_badmessage_should_delegate_failure{
    didFailWithErrorWasCalled = [self expectationWithDescription:@"Expect Failure Callback"];
    NSDictionary* message = @{
        @"messageType": @"VirtualCheckoutSuccessfulMessage",
        @"message": @{
                @"card": @"invalid card data",
        }
    };
    [checkoutVC viewController:checkoutVC didReceiveScriptMessage:message];
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertTrue(error == NULL);
    }];
}

- (void)checkoutCancelled:(nonnull QuadPayVirtualCheckoutViewController *)viewController reason:(nonnull NSString *)reason {
    [checkoutCancelledWasCalled fulfill];
}
- (void)checkoutSuccessful:(nonnull QuadPayVirtualCheckoutViewController *)viewController card:(nonnull QuadPayCard *)card cardholder:(nonnull QuadPayCardholder *)cardholder customer:(nonnull QuadPayCustomer *)customer orderId:(nonnull NSString*)orderId {
    [checkoutSucceededWasCalled fulfill];
}
- (void)didFailWithError:(nonnull QuadPayVirtualCheckoutViewController *)viewController error:(nonnull NSString *)error {
    errorWhenFailed = error;
    // Fulfill and remove. Subsequent messages to nil are ignored.
    [didFailWithErrorWasCalled fulfill];
    didFailWithErrorWasCalled = nil;
}

@end
