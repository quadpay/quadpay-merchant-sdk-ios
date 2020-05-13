//
//  ViewController.m
//  SDKExample
//

//  Copyright © 2020 QuadPay. All rights reserved.
//

#import "ViewController.h"
#import <QuadPaySDK/QuadPaySDK.h>

@interface ViewController () <QuadPayVirtualCheckoutDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)checkoutButtonPressed:(UIButton *)sender {
    //NSLog(@"Button Pressed");
    QuadPayVirtualCheckoutViewController* view = [QuadPayVirtualCheckoutViewController startCheckout:self];
    [self presentViewController:view animated:YES completion:nil];
}

- (void)didFailWithError:(QuadPayVirtualCheckoutViewController*)viewController error:(nonnull NSError *)error {
    NSLog(@"QuadPay checkout encountered an error");
}

- (void)checkoutCancelled:(QuadPayVirtualCheckoutViewController*)viewController reason:(NSString *)reason {
    NSLog([NSString stringWithFormat:@"User cancelled QuadPay checkout with reason %@", reason]);
    [viewController dismissViewControllerAnimated:true completion:^ {
        [self showUserCancelledAlert];
    }];
}

- (void)checkoutCancelled:(QuadPayVirtualCheckoutViewController*)viewController {
    NSLog(@"User cancelled QuadPay checkout");
    [viewController dismissViewControllerAnimated:true completion:^ {
        [self showUserCancelledAlert];
    }];
}

- (void) checkoutSuccessful:(QuadPayVirtualCheckoutViewController*)viewController card:(nonnull QuadPayCard *)card cardholder:(nonnull QuadPayCardholder *)cardholder {
    NSLog([NSString stringWithFormat:@"Card: %@ Issued for %@", [card toString], [cardholder toString]]);
    [viewController dismissViewControllerAnimated:true completion:^ {
        [self showCheckoutSuccessAlert:card cardholder:cardholder];
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

- (void)showCheckoutSuccessAlert:(QuadPayCard*) card cardholder:(QuadPayCardholder*) cardholder {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Checkout Succeeded"
                                                                   message:[NSString stringWithFormat:
                                                                            @"QuadPay checkout succeeded, card issued: %@", card.number]
                                   preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {}];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
