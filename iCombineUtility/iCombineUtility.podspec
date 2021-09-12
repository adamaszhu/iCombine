Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "iCombineUtility"
s.summary = "iCombineUtility provides additional support to Combine and iCombine."
s.requires_arc = true
s.version = "0.4.3"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Adamas Zhu" => "developer@adamaszhu.com",
"Leon Nguyen" => "leon.nguyen291@gmail.com" }
s.homepage = "https://github.com/adamaszhu/iCombine"
s.source = { :git => "https://github.com/adamaszhu/iCombine.git",
:tag => "#{s.version}" }
s.source_files = "iCombineUtility/**/*.{swift}"
s.swift_version = "5"

s.framework = "Foundation"
s.dependency 'iCombine', '~> 0.3.5'

end
