//
//  ViewController.m
//  SDKExample
//
//  Created by Paul Sauer on 5/11/20.
//  Copyright © 2020 QuadPay. All rights reserved.
//

#import "ViewController.h"
#import <QuadPaySDK/QuadPayCheckoutViewController.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)checkoutButtonPressed:(UIButton *)sender {
    NSLog(@"Button Pressed");
    QuadPayCheckoutViewController* view;
}

@end
