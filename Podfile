# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

require_relative 'Flutter/mani_plugins_installer'

target 'ManiAuthExampleNoPlugins' do
  use_frameworks!
  pod 'Flutter', :podspec => 'Flutter/Debug/Flutter.podspec'
  pod 'App', :podspec => 'Flutter/Debug/App.podspec'
  use_flutter_modules!

  post_install do |installer|
    flutter_post_install(installer)
  end
end
