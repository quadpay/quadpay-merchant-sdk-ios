Pod::Spec.new do |s|
  s.name						= 'QuadPaySDK'
  s.authors						= "QuadPay, Inc."
  s.version						= '0.4.0'
  s.summary						= 'Integrate QuadPay into your iOS app'
  s.homepage					= 'https://github.com/quadpay/quadpay-merchant-sdk-ios'
  s.license						= { :type => "mit", :file => "LICENSE" }
  s.source						= { :git => 'https://github.com/quadpay/quadpay-merchant-sdk-ios.git', :tag => s.version.to_s, :branch => 'petros/CKO-1653/ios-widget' }
  s.ios.deployment_target		= '9.0'
  s.source_files				    = 'QuadPaySDK/**/*.{h,m,swift}'
  s.resources               = 'QuadPaySDK/*.xcassets', 'QuadPaySDK/www'
  s.requires_arc            = true
  s.frameworks					    = 'UIKit', 'Foundation', 'Security', 'WebKit'
  s.dependency "Analytics", "~> 4.1"
end
 
