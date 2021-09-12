Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "iCombineNetwork"
s.summary = "iCombineNetwork allows a project to construct the network layer using Combine before iOS 13."
s.requires_arc = true
s.version = "0.4.5"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Adamas Zhu" => "developer@adamaszhu.com",
"Leon Nguyen" => "leon.nguyen291@gmail.com" }
s.homepage = "https://github.com/adamaszhu/iCombine"
s.source = { :git => "https://github.com/adamaszhu/iCombine.git",
:tag => "#{s.version}" }
s.source_files = "iCombineNetwork/iCombineNetwork/**/*.{swift}"
s.swift_version = "5"

s.framework = "Foundation"
s.dependency 'iCombine', '~> 0.3.5'

end
