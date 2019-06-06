# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

# This is used to allow the CI build to work. The pod(s) are
# signed with the credentials / profile provided and xcodebuild
# is not happy with this. If you Pods are check in to SCM, and not
# updated by the CI build process then you may not need this.
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = "-"
      config.build_settings['EXPANDED_CODE_SIGN_IDENTITY_NAME'] = "-"
      config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
      config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
    end
  end
end

target 'MyRangeBCManager' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MyRangeBCManager
  pod 'RealmSwift'
  pod 'IQKeyboardManagerSwift', '6.1.1'
  pod 'ReachabilitySwift', '4.2.1'
  pod 'Alamofire'
  pod 'SwiftyJSON', '4.1.0'
  pod 'lottie-ios', '2.5.0'
  pod 'SingleSignOn', :git => 'https://github.com/bcgov/mobile-authentication-ios.git', :tag => 'v1.0.6'
  pod 'Extended'
  pod 'Designer'
end
