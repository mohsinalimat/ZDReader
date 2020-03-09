#
#  Be sure to run `pod spec lint QSNetwork.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
s.name         = "QSNetwork"
s.version      = "0.0.3"
s.summary      = "a network tool."
s.description  = <<-DESC
this project is a network tool
DESC
s.homepage     = "https://github.com/NoryCao/QSNetwork"
s.license      = "MIT"
s.author             = { "Nory Cao" => "2252055382@qq.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/NoryCao/QSNetwork.git", :tag => "#{s.version}" }
s.source_files  = "Source", "QSNetwork/Source/*.{h,m,swift}"
s.requires_arc = true
end
