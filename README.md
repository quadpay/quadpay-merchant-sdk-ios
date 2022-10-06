QuadPay iOS SDK
===

The QuadPay iOS SDK enables you to offer buy-now-pay-later functionality in your iOS app!

Installation
===

<strong> CocoaPods </strong>

Add the following to your Podfile and run `pod install`
```ruby
pod 'QuadPaySDK'
```

<strong> Source & Resource Files </strong>
```ruby
s.source_files = 'QuadPaySDK/**/*.{h,m,swift}'
```

We are limiting the files bringing inside the development pod otherwise we will bring info.plist as well and that will cause the build of the app to fail as you are not allow to have multiple info.plist files inside an app.

```ruby
s.resources = 'QuadPaySDK/*.xcassets', 'QuadPaySDK/www'
```

To include the assets inside the development pod under the same directory as the quadpaySDK code and not outside. 

Integration documentation
===

Please find integration documentation at [https://docs.us.zip.co/docs/mobile-sdk-ios](https://docs.us.zip.co/docs/mobile-sdk-ios).

Storing Secrets in SDK
===
Please review the documentation [here](Keys/README.md) to learn more about storing secrets in the SDK.


Example
===

This repo also contains a demo app at `./Example` to show a basic implementation of the QuadPay SDK.
