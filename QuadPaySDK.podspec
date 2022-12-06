Pod::Spec.new do |s|
  s.name						= 'QuadPaySDK'
  s.authors						= "Zip Co."
  s.version						= '0.5.11'
  s.summary						= 'Integrate Zip (formally QuadPay) into your iOS app'
  s.homepage					= 'https://github.com/quadpay/quadpay-merchant-sdk-ios'
  s.license						= { :type => "mit", :file => "LICENSE" }
  s.source						= { :git => 'https://github.com/quadpay/quadpay-merchant-sdk-ios.git', :tag => s.version.to_s }
  s.ios.deployment_target		= '12.0'
  s.source_files				    = 'QuadPaySDK/**/*.{h,m,swift}'
  s.resources               = 'QuadPaySDK/*.xcassets', 'QuadPaySDK/www'
  s.requires_arc            = true
  s.frameworks					    = 'UIKit', 'Foundation', 'Security', 'WebKit'
  s.dependency "Analytics", "~> 4.1"
  s.dependency "FingerprintJS"
  s.swift_version = '5.7'
end
