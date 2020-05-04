
## Overview
Items you will need:

-The QuadPay iOS SDK  
-The Start Checkout call in your iOS app  
-An order confirmation endpoint on your server  


## Implementation

### The QuadPay iOS SDK

- Our SDK is currently only available privately, please inquire about an integration (##sales email?) for more information.

### How to start a QuadPay checkout in your iOS App

#### Initialize the QuadPay SDK

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

#### Provide a button that will start the QuadPay checkout by calling

Once presented the customer will be shown the QuadPay checkout flow.

```
UINavigationController *navController = [
  QuadPay startCheckout
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

#### Implement the QPCheckoutDelegate functions

These functions give your application information regarding the result of the QuadPay checkout flow.

##### Checkout Success

This function returns a token you may exchange to confirm an order has been created.

```
- (void)checkoutSuccessful:(NSString *)token
{
    // The user has completed checkout -- see the section on token exchange for handling this token
    NSLog(@"QuadPay checkout succeeded with token: %@", token);
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

### Exchanging QuadPay tokens for confirmed orders

As soon as your customer has confirmed their order you must exchange the QuadPay token. Tokens have a duration of 24 hours after which they can no longer be exchanged for orders.

The timing of your shipping can be any time *after* you have exchanged the token. When submitting the token you will have a chance to finalize the order amount.

#### Post the token

See https://docs.quadpay.com/docs/custom-integration-guide#signing-requests for information regarding signing requests

Post the token:

```
curl -X post https://gateway.quadpay.com/checkout/exchange_token
  -H 'content-type: application/json' 
  -H 'X-QP-Signature: [signature]'
  -d '{
    "token": [token],
    "orderTotalAmount": [amount],
  }'
```

An order id will be returned:

```
{
  "orderId": [order id]
}
```

#### Service after confirmation

Once the order has been confirmed and an order id has been received the user should be guided to a success page.

This order id can also be used to update the order using our normal orders integration api at https://docs.quadpay.com/docs/custom-integration-guide

