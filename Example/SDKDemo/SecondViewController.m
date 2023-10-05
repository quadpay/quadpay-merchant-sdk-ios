//
//  SecondViewController.m
//  SDKDemo
//
//  Created by Paul Sauer on 5/19/20.
//  Copyright © 2020 QuadPay. All rights reserved.
//

#import "SecondViewController.h"
#import <ZipSDK/ZipSDK.h>

@interface SecondViewController () <ZipVirtualCheckoutDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)checkoutButtonPressed:(id)sender {
    /*
        This action handler is where the QuadPay checkout is started
     */
    ZipCheckoutDetails* details = [ZipCheckoutDetails alloc];
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

    ZipVirtualCheckoutViewController* view = [ZipVirtualCheckoutViewController startCheckout:self details:details];
    [self presentViewController:view animated:YES completion:nil];
}

- (void)didFailWithError:(ZipVirtualCheckoutViewController*)viewController error:(nonnull NSString *)error {
    [viewController dismissViewControllerAnimated:true completion:^ {}];
    NSLog(@"%@", [NSString stringWithFormat:@"QuadPay checkout encountered an error %@", error]);
}

- (void)checkoutCancelled:(ZipVirtualCheckoutViewController*)viewController reason:(NSString *)reason {
    NSLog(@"%@", [NSString stringWithFormat:@"User cancelled QuadPay checkout with reason %@", reason]);
    [viewController dismissViewControllerAnimated:true completion:^ {
        /*
            Your code to handle cancellation (if any), this demo just shows an alert!
         */
        [self showUserCancelledAlert];
    }];
}

- (void) checkoutSuccessful:(ZipVirtualCheckoutViewController*)viewController card:(nonnull ZipCard *)card cardholder:(nonnull ZipCardholder *)cardholder customer:(nonnull ZipCustomer *)customer {
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

- (void)showCheckoutSuccessAlert:(ZipCard*) card cardholder:(ZipCardholder*) cardholder customer:(ZipCustomer*) customer {
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
