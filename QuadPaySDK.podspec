Pod::Spec.new do |s|
  s.name						= 'QuadPaySDK'
  s.authors						= "QuadPay, Inc."
  s.version						= '0.0.1'
  s.summary						= 'Integrate QuadPay into your iOS app'
  s.homepage					= 'https://github.com/quadpay/quadpay-merchant-sdk-ios'
  s.license						= { :type => "BSD-3-Clause", :file => "LICENSE" }
  s.source						= { :git => 'https://github.com/quadpay/quadpay-merchant-sdk-ios.git', :tag => s.version.to_s }
  s.ios.deployment_target		= '9.0'
  s.source_files				= 'QuadPaySDK/*.{h,m}'
  s.resource					= 'QuadPaySDK/QuadPaySDK.bundle'
  s.public_header_files			= 'QuadPaySDK/*.h'
  s.frameworks					= 'UIKit', 'Foundation', 'Security', 'WebKit'
end
 