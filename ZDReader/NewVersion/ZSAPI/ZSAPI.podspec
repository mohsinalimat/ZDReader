#
# Be sure to run `pod lib lint ZSAPI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZSAPI'
  s.version          = '1.0.15'
  s.summary          = 'ZSAPI.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
zhuishushenqi baseui module.
                       DESC

  s.homepage         = 'https://github.com/zssq/ZSAPI'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '2252055382@qq.com' => 'Noah' }
  s.source           = { :git => 'https://github.com/zssq/ZSAPI.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/Noah'

  s.ios.deployment_target = '8.0'
  
  s.swift_version = '5.0'

  s.source_files = 'ZSAPI/Classes/**/*'
  
   s.resource_bundles = {
     'ZSAPI' => ['ZSAPI/Assets/*.png']
   }


#s.frameworks = 'UIKit', 'SystemConfiguration', 'Security', 'CoreTelephony', 'CFNetwork', 'CoreGraphics', 'CoreText', 'QuartzCore', 'ImageIO', 'Photos'
#s.libraries = 'z', 'sqlite3.0', 'c++'

#s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'


end
