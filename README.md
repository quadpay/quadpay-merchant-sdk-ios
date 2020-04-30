QuadPay iOS SDK
==============

The QuadPay iOS SDK enables you to offer buy-now-pay-later functionality in your iOS app!

Installation
============

<strong> CocoaPods </strong>

Add the following to your Podfile and run `pod install`
```ruby
pod 'QuadPaySDK'
```

Usage Overview
==============

The QuadPay iOS SDK offers two components: a checkout view controller and an [TBD] informational widget

Before you can use these you must configure:
--PUBLISHABLE_KEY
--Merchant Name
--Locale (US only)
--Environment (UT, PD)

## Performing a Checkout

### Opening the QuadPay flow

Create a QuadPayVCViewController
Call QuadPayVCViewController.startCheckout(...)

### Implement QuadPayVCDelegate

This delegate provides critical lifecycle callbacks for the QuadPay process. See https://docs.quadpay.com/docs/virtual-checkout for more information.

#### OnSuccess

This function is called when a customer has successfully completed the QuadPay flow and is approved to make a transaction. It contains all the information you need to charge the item.


#### OnClose

This function is called when the customer closes the QuadPay flow or is declined and will contain a message describing the situation.


#### OnError

This function is called in the case an error occurs during the QuadPay workflow.

## [TBD] Using the widget

In development.

Example
=======

This repo also contains a demo app to show a basic implementation of the QuadPay SDK.


Technical Notes
==============

Open Qs:
How to i18n?


Input Config
merchantId="{PUBLISHABLE_KEY}

Input to C/O
    quadpayButton.setAttribute('amount', 123.45);
    quadpayButton.setAttribute('merchantReference', 'unique-order-id');
    quadpayButton.setAttribute('customerFirstName', 'QuadPay');
    quadpayButton.setAttribute('customerLastName', 'Customer');
    quadpayButton.setAttribute('customerEmail', 'email@example.com');
    quadpayButton.setAttribute('customerPhoneNumber', '+15555555555');
    quadpayButton.setAttribute('customerAddressLine1', '123 Main St.');
    quadpayButton.setAttribute('customerAddressLine2', '10th Floor');
    quadpayButton.setAttribute('customerCity', 'New York');
    quadpayButton.setAttribute('customerState', 'NY');
    quadpayButton.setAttribute('customerPostalCode', '10003');
    quadpayButton.setAttribute('customerCountry', 'USA');


Interfaces


UINavigationController *navController = [
  QPVCViewController startCheckout
    delegate:self
];
[self presentViewController:navController animated:YES completion:nil];


Provide Delegate Pattern for Results

QP suggested:

QuadPayVCViewController startQuadPayCheckout(
  delegate: self
)

QuadPayVCDelegate
--Attempts to mirror QPJS naming so that we provide a consistent interface across our SDKs

void onSuccess(
  QuadPayCard card
  QuadPayCardHolder cardHolder
  QuadPayCustomer customer
)

void onClose(
  NSString* message
)

void onError(
  NSError* error
)

void onDecline(
  QuadPayDeclineReceipt receipt
)
