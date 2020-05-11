//
//  ViewController.m
//  SDKExample
//
//  Created by Paul Sauer on 5/11/20.
//  Copyright © 2020 QuadPay. All rights reserved.
//

#import "ViewController.h"
#import <QuadPaySDK/QuadPayCheckoutViewController.h>
#import <QuadPayCheckoutDelegate.h>

@interface ViewController () <QuadPayCheckoutDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)checkoutButtonPressed:(UIButton *)sender {
    NSLog(@"Button Pressed");
    QuadPayCheckoutViewController* view = [QuadPayCheckoutViewController startCheckout:self];
    [self presentViewController:view animated:YES completion:nil];
}

- (void)checkout:(nonnull QuadPayCheckoutViewController *)checkoutViewController completedWithToken:(nonnull NSString *)checkoutToken {
    
}

- (void)checkout:(nonnull QuadPayCheckoutViewController *)checkoutViewController didFailWithError:(nonnull NSError *)error {
    
}

- (void)checkoutCancelled:(nonnull QuadPayCheckoutViewController *)checkoutViewController {
    
}

- (void)checkoutCancelled:(nonnull QuadPayCheckoutViewController *)checkoutViewController checkoutCanceledWithReason:(nonnull NSString *)reasonCode {
    
}

- (void)vcnCheckout:(nonnull QuadPayCheckoutViewController *)checkoutViewController completedWithCreditCard:(nonnull NSString *)creditCard {
    
}

//- (void)encodeWithCoder:(nonnull NSCoder *)coder {
//
//}
//
//- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
//
//}
//
//- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//
//}

//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//
//}
//
//- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//
//}
//
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//
//}
//
//- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//
//}
//
//- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
//
//}
//
//- (void)setNeedsFocusUpdate {
//
//}

//- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
//
//}

//- (void)updateFocusIfNeeded {
//
//}

@end
