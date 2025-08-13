# Uncomment the next line to define a global platform for your project
 platform :ios, '15.0'

require_relative 'Flutter/mani_plugins_installer'

target 'ManiAuthExampleNoPlugins' do
  use_frameworks!
  pod 'Flutter', :podspec => 'Flutter/Release/Flutter.podspec'
  pod 'App', :podspec => 'Flutter/Release/App.podspec'
  use_flutter_modules!

  post_install do |installer|
    flutter_post_install(installer)
  end
end
