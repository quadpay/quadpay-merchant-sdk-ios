
## Overview
Items you will need:

-The QuadPay iOS SDK  
-The Start Checkout call in your iOS app  
-A payment processor for credit card transactions  


## Implementation

### The QuadPay iOS SDK

#### 1. Our SDK is currently only available privately, please inquire about an integration (##sales email?) for more information.

### How to start a QuadPay checkout in your iOS App

#### 1. Initialize the QuadPay SDK:

Typically this is done in `didFinishLaunchingWithOptions`:

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[QuadPay sharedInstance] initialize:@"{{PUBLISHABLE_KEY}}"
      environment:@"production"
      locale:@"US"
    ];
    return YES;
}
```

#### 2. Provide a button that will start the QuadPay checkout by calling:

Once presented the customer will be shown the QuadPay checkout flow.

```
UINavigationController *navController = [
  QuadPay startVirtualCheckout
    delegate:self
    amount:@"123.45"
    merchantReference"@"unique-order-id"
    customerFirstName@"QuadPay"
    customerLastName:@"Customer"
    customerEmail:@"email@example.com"
    customerPhoneNumber:@"+15555555555"
    customerAddressLine1:@"123 Main St."
    customerAddressLine2:@"10th Floor"
    customerCity:@"New York"
    customerState:@"NY"
    customerPostalCode:@"10003"
    customerCountry:@"US"
];
[self presentViewController:navController animated:YES completion:nil];
```

#### 3. Implement the QPVirtualCheckoutDelegate functions:

These functions give your application information regarding the result of the QuadPay checkout flow.

##### Checkout Success

This function returns a token you may exchange to confirm an order has been created.

```
- (void)checkoutSuccessful:(QuadPayCard *)card cardholder:(QuadPayCardHolder *)cardholder
{
    // The user has completed checkout
    // A virtual card has been returned
    // Pass the details in card and cardholder into your standard payment processor
}
```

##### Checkout Cancelled

This function is called when the user cancels the QuadPay process or is declined.

```
- (void)checkoutCancelled:(NSString *)reason
{
    // The QuadPay checkout session has been cancelled
    NSLog(@"QuadPay checkout cancelled, reason: %@", reason);
}
```

### Finishing the QuadPay order

Once you have received a virtual card number in a success delegate you may authorize and capture it up to the value provided at the beginning of checkout. The card that is issued is a standard Visa card and all authorize/capture/refund functionality will work as expected.

More information and frequently asked questions are available at https://docs.quadpay.com/docs/virtual-checkout
