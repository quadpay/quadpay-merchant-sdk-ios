//
//  SecondViewController.m
//  SDKDemo
//
//  Created by Paul Sauer on 5/19/20.
//  Copyright © 2020 QuadPay. All rights reserved.
//

#import "SecondViewController.h"
#import <QuadPaySDK/QuadPaySDK.h>

@interface SecondViewController () <QuadPayVirtualCheckoutDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)checkoutButtonPressed:(id)sender {
    /*
        This action handler is where the QuadPay checkout is started
     */
    QuadPayCheckoutDetails* details = [QuadPayCheckoutDetails alloc];
    details.amount = [NSDecimalNumber decimalNumberWithString:@"94.40" locale:NULL];
    details.customerPhoneNumber = @"+18146225937";
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

    QuadPayVirtualCheckoutViewController* view = [QuadPayVirtualCheckoutViewController startCheckout:self details:details];
    [self presentViewController:view animated:YES completion:nil];
}

- (void)didFailWithError:(QuadPayVirtualCheckoutViewController*)viewController error:(nonnull NSString *)error {
    [viewController dismissViewControllerAnimated:true completion:^ {}];
    NSLog(@"%@", [NSString stringWithFormat:@"QuadPay checkout encountered an error %@", error]);
}

- (void)checkoutCancelled:(QuadPayVirtualCheckoutViewController*)viewController reason:(NSString *)reason {
    NSLog(@"%@", [NSString stringWithFormat:@"User cancelled QuadPay checkout with reason %@", reason]);
    [viewController dismissViewControllerAnimated:true completion:^ {
        /*
            Your code to handle cancellation (if any), this demo just shows an alert!
         */
        [self showUserCancelledAlert];
    }];
}

- (void) checkoutSuccessful:(QuadPayVirtualCheckoutViewController*)viewController card:(nonnull QuadPayCard *)card cardholder:(nonnull QuadPayCardholder *)cardholder customer:(nonnull QuadPayCustomer *)customer {
    NSLog(@"%@", [NSString stringWithFormat:@"Card: %@ Issued for %@", [card toString], [cardholder toString]]);
    [viewController dismissViewControllerAnimated:true completion:^ {
        /*
            Your code to handle order creation with the provided card details, this demo just shows an alert!
         */
        [self showCheckoutSuccessAlert:card cardholder:cardholder customer:customer];
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

- (void)showCheckoutSuccessAlert:(QuadPayCard*) card cardholder:(QuadPayCardholder*) cardholder customer:(QuadPayCustomer*) customer {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Checkout Succeeded"
                                                                   message:[NSString stringWithFormat:
                                                                            @"QuadPay checkout succeeded, card issued: %@", card.number]
                                   preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {}];
 
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    NSLog(@"%@", [NSString stringWithFormat:
           @"QuadPay checkout succeeded, card issued: %@, customer: %@", card.number, [customer toString]]);
}

@end
