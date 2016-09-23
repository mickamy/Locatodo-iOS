# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'Locatodo' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Locatodo
  pod 'RealmSwift'
  pod 'XCGLogger', '~> 4.0.0'
  pod 'RxSwift', '~> 3.0.0-beta.1'
  pod 'RxCocoa', '~> 3.0.0-beta.1'
  pod 'R.swift', '~> 3.0.0'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = "3.0"
        end
    end
end
