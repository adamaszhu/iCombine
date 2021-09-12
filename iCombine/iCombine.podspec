Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '8.0'
s.name = "iCombine"
s.summary = "iCombine allows a project to use Combine syntax before iOS 13."
s.requires_arc = true
s.version = "0.4.2"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Adamas Zhu" => "developer@adamaszhu.com",
"Leon Nguyen" => "leon.nguyen291@gmail.com" }
s.homepage = "https://github.com/adamaszhu/iCombine"
s.source = { :git => "https://github.com/adamaszhu/iCombine.git",
:tag => "#{s.version}" }
s.source_files = "iCombine/**/*.{swift}"
s.swift_version = "5"

s.framework = "Foundation"
s.dependency 'RxSwift', '~> 5'
s.dependency 'RxCocoa', '~> 5'

end
