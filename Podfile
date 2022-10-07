# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

project 'QuadPaySDK'

plugin 'cocoapods-keys', {
  :project => 'QuadPaySDK',
  :keys => [
    'SegmentWriteKey',
    'TestKey'
  ]
}

target 'QuadPaySDK' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for QuadPaySDK
  pod "Analytics", "~> 4.1"
  pod 'FingerprintJS'

  target 'QuadPaySDKTests' do
    # Pods for testing
  end

end
