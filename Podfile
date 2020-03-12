source 'https://github.com/CocoaPods/Specs.git'
#source 'https://github.com/sinaweibosdk/weibo_ios_sdk.git'

# 对于Swift应用来说下面两句是必须的
platform :ios, '10.0'
#use_frameworks!
# Swift静态库方式
use_modular_headers!
inhibit_all_warnings!
branch = ENV['sha']

# target的名字一般与你的项目名字相同
target 'ZDReader' do
project './ZDReader.xcodeproj'

pod 'YYText'
pod 'YYModel'
pod 'YYImage'
pod 'MBProgressHUD'
pod 'MJRefresh'
pod 'CocoaAsyncSocket'
pod 'CocoaLumberjack', '3.4.2'
pod 'YYCategories'
pod 'FMDB'
#pod 'WechatOpenSDK'
#pod 'Weibo_SDK'

# swift libraries
pod 'Alamofire'
pod 'Cache'
pod 'HandyJSON'
pod 'Kingfisher'
pod 'PKHUD'
pod 'SnapKit', '5.0.0'
pod 'SQLite.swift'
pod 'Zip'
pod 'RxAlamofire'
pod 'RxCocoa'
pod 'UICircularProgressRing'

# local pods
pod 'ZSAPI', :path => "ZDReader/NewVersion/ZSAPI"
pod 'ZSAppConfig', :path => "ZDReader/NewVersion/ZSAppConfig"
pod 'ZSExtension', :path => "ZDReader/NewVersion/ZSExtension"

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    # 我們也可以懶惰不用 if，讓所有 pod 的版本都設為一樣的
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.0'
    end
    
#    if ['RxSwift', 'RxSwiftExt', 'RxCocoa', 'RxDataSources', 'ProtocolBuffers-Swift'].include? target.name
#    end
  end
end
