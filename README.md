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

s.source_files = 'QuadPaySDK/**/*.{h,m,swift}'

We are limiting the files bringing inside the development pod otherwise we will bring info.plist as well and that will cause the build of the app to fail as you are not allow to have multiple info.plist files inside an app.


s.resources = 'QuadPaySDK/*.xcassets', 'QuadPaySDK/www'

To include the assets inside the development pod under the same directory as the quadpaySDK code and not outside. 

Integration documentation
==============

Please find integration documentation at https://docs.quadpay.com/docs/mobile-sdk-ios


Example
=======

This repo also contains a demo app to show a basic implementation of the QuadPay SDK.
