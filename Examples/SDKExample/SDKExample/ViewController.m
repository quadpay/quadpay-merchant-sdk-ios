//
//  ViewController.m
//  SDKExample
//
//  Copyright © 2020 QuadPay. All rights reserved.
//

#import "ViewController.h"
#import <QuadPaySDK/QuadPaySDK.h>

@interface ViewController () <QuadPayCheckoutDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)checkoutButtonPressed:(UIButton *)sender {
    /*
        This action handler is where the QuadPay checkout is started
     */
    QuadPayCheckoutDetails* details = [QuadPayCheckoutDetails alloc];
    details.amount = [NSDecimalNumber decimalNumberWithString:@"94.40" locale:NULL];
    details.customerPhoneNumber = @"+1231231234";
    details.customerEmail = @"sdk_example@quadpay.com";

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

- (void) checkoutSuccessful:(QuadPayCheckoutViewController*)viewController token:(NSString*)token {
    NSLog(@"%@", [NSString stringWithFormat:@"Confirmation token %@", token]);
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
