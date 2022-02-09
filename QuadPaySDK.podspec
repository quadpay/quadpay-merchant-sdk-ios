Pod::Spec.new do |s|
  s.name						= 'QuadPaySDK'
  s.authors						= "QuadPay, Inc."
  s.version						= '0.4.0'
  s.summary						= 'Integrate QuadPay into your iOS app'
  s.homepage					= 'https://github.com/quadpay/quadpay-merchant-sdk-ios'
  s.license						= { :type => "mit", :file => "LICENSE" }
  s.source						= { :git => 'https://github.com/quadpay/quadpay-merchant-sdk-ios.git', :tag => s.version.to_s }
  s.ios.deployment_target		= '9.0'
  s.source_files				    = 'QuadPaySDK/**/*.{h,m}'
  s.frameworks					    = 'UIKit', 'Foundation', 'Security', 'WebKit'
end
 
