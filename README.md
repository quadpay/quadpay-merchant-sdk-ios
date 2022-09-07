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

<strong> Local Development </strong>

Inside podspec file change the 

s.source = { :git => 'https://github.com/quadpay/quadpay-merchant-ios.git', :tag => s.version.to_s}

to

s.source = { :git => 'https://github.com/quadpay/quadpay-merchant-ios.git', :tag => s.version.to_s, :branch => 'your branch'}


Integration documentation
==============

Please find integration documentation at https://docs.quadpay.com/docs/mobile-sdk-ios


Example
=======

This repo also contains a demo app to show a basic implementation of the QuadPay SDK.
