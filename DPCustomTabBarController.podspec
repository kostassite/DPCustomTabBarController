#
# Be sure to run `pod lib lint DPCustomTabBarController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DPCustomTabBarController'
  s.version          = '1.2'
  s.summary          = 'A UITabBarController subclass with custom view and buttons'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This library allows to use any UIView as UITabBarController and any button on it to work at TabBar Button Item.
DESC

  s.homepage         = 'https://github.com/kostassite/DPCustomTabBarController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kostas Antonopoulos' => 'kostas@devpro.gr' }
  s.source           = { :git => 'https://github.com/kostassite/DPCustomTabBarController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'DPCustomTabBarController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DPCustomTabBarController' => ['DPCustomTabBarController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
