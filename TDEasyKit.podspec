#
#  Be sure to run `pod spec lint TDEasyKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
s.name         = "TDEasyKit"
s.version      = "1.0.0"
s.summary      = "The Kit build base views for iCheck"
s.homepage     = "https://github.com/kinhvodoi92/TDEasyKit"
s.license      = { :type => 'MIT', :file => 'LICENSE' }
s.author       = { "Dang Trung Duc" => "dangtrungduc92@gmail.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/kinhvodoi92/TDEasyKit.git", :tag => s.version }
s.source_files  = 'TDEasyKit/**/*.{h,m}'
s.ios.framework = 'UIKit'
end
