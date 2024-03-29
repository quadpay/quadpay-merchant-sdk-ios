Pod::Spec.new do |s|
  s.name						= 'QuadPaySDK'
  s.authors						= "Zip Co."
  s.version						= '1.2.0'
  s.summary						= 'Integrate Zip (formally QuadPay) into your iOS app'
  s.homepage					= 'https://github.com/quadpay/quadpay-merchant-sdk-ios'
  s.license						= { :type => "mit", :file => "LICENSE" }
  s.source						= { :git => 'https://github.com/quadpay/quadpay-merchant-sdk-ios.git', :tag => s.version.to_s }
  s.ios.deployment_target		= '13.0'
  s.source_files				    = 'QuadPaySDK/**/*.{h,m,swift}'
  s.resource_bundles        = {'QuadPaySDK' => ['QuadPaySDK/*.xcassets','QuadPaySDK/www', 'QuadPaySDK/Configuration/*.plist', 'QuadPaySDK/Font'] } 
  s.requires_arc            = true
  s.frameworks					    = 'UIKit', 'Foundation', 'Security', 'WebKit'
  s.swift_version = '5.7'
end
