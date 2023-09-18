Pod::Spec.new do |s|
  s.name						= 'ZipSDK'
  s.authors						= "Zip Co."
  s.version						= '1.2.0'
  s.summary						= 'Integrate Zip (formally QuadPay) into your iOS app'
  s.homepage					= 'https://github.com/quadpay/quadpay-merchant-sdk-ios'
  s.license						= { :type => "mit", :file => "LICENSE" }
  s.source						= { :git => 'https://github.com/quadpay/quadpay-merchant-sdk-ios.git', :tag => s.version.to_s }
  s.ios.deployment_target		= '13.0'
  s.source_files				    = 'ZipSDK/**/*.{h,m,swift}'
  s.resource_bundles        = {'ZipSDK' => ['ZipSDK/*.xcassets','ZipSDK/www', 'ZipSDK/Configuration/*.plist', 'ZipSDK/Font'] } 
  s.requires_arc            = true
  s.frameworks					    = 'UIKit', 'Foundation', 'Security', 'WebKit'
  s.swift_version = '5.7'
end
