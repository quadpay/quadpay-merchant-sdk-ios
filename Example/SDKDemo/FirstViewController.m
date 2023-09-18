//
//  FirstViewController.m
//  SDKDemo
//
//  Created by Paul Sauer on 5/19/20.
//  Copyright © 2020 QuadPay. All rights reserved.
//

#import "FirstViewController.h"
#import <ZipSDK/QuadPaySDK.h>

@interface FirstViewController () <QuadPayCheckoutDelegate>

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)checkoutButtonPressed:(id)sender {
    /*
        This action handler is where the QuadPay checkout is started
     */

    QuadPayCheckoutDetails* details = [QuadPayCheckoutDetails alloc];
    details.amount = [NSDecimalNumber decimalNumberWithString:@"94.40" locale:NULL];
    details.customerPhoneNumber = @"+8146225937";
    details.customerCity = @"New York";
    details.customerState = @"NY";
    details.customerAddressLine1 = @"240 Meeker Ave";
    details.customerAddressLine2 = @"Apt 35";
    details.customerPostalCode = @"11211";
    details.customerCountry = @"US";
    details.customerFirstName = @"Quincy";
    details.customerLastName = @"Payman";
    details.customerEmail = @"sdk_example@quadpay.com";
    details.checkoutFlow = @"express";

    QuadPayCheckoutViewController* view = [QuadPayCheckoutViewController startCheckout:self details:details];
    [self presentViewController:view animated:YES completion:nil];
}

- (void)didFailWithError:(QuadPayCheckoutViewController*)viewController error:(nonnull NSString *)error {
    [viewController dismissViewControllerAnimated:true completion:^ {}];
    NSLog(@"%@", [NSString stringWithFormat:@"QuadPay checkout encountered an error %@", error]);
}

- (void)checkoutCancelled:(QuadPayCheckoutViewController*)viewController reason:(NSString *)reason {
    NSLog(@"%@", [NSString stringWithFormat:@"User cancelled QuadPay checkout with reason %@", reason]);
    [viewController dismissViewControllerAnimated:true completion:^ {
        /*
            Your code to handle cancellation (if any), this demo just shows an alert!
         */
        [self showUserCancelledAlert];
    }];
}

- (void) checkoutSuccessful:(QuadPayCheckoutViewController*)viewController orderId:(NSString*)orderId {
    NSLog(@"%@", [NSString stringWithFormat:@"Confirmation orderId %@", orderId]);
    [viewController dismissViewControllerAnimated:true completion:^ {
        /*
            Pass this token to your backend to complete the order!
         */
        [self showCheckoutSuccessAlert];
    }];
}

- (void) checkoutSuccessful:(QuadPayCheckoutViewController*)viewController orderId:(NSString*)orderId customer:(QuadPayCustomer*)customer {
    NSLog(@"%@", [NSString stringWithFormat:@"Confirmation orderId %@, customer: %@", orderId, [customer toString]]);
    [viewController dismissViewControllerAnimated:true completion:^ {
        /*
         Pass this token to your backend to complete the order!
         */
        [self showCheckoutSuccessAlert];
    }];
}


- (void)showUserCancelledAlert {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"User Cancelled"
                                                                   message:@"The user has cancelled the QuadPay checkout!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showCheckoutSuccessAlert {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Checkout Succeeded"
                                                                   message: @"QuadPay checkout succeeded"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
