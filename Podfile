# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Ibeacon_test' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Ibeacon_test
  pod 'SwiftyJSON', '2.4.0'
  pod 'Alamofire', '~> 3.5'
  pod 'ActionCableClient', '0.1.6'


  target 'Ibeacon_testTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Ibeacon_testUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

# Forces ActionCableClient specifically to support Swift 2.3
# https://github.com/danielrhodes/Swift-ActionCableClient/issues/10
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '2.3'
        end
    end
end

