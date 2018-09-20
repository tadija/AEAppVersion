Pod::Spec.new do |s|

s.name = 'AEAppVersion'
s.version = '0.4.0'
s.license = { :type => 'MIT', :file => 'LICENSE' }
s.summary = 'Simple and lightweight iOS App Version Tracking written in Swift'

s.source = { :git => 'https://github.com/tadija/AEAppVersion.git', :tag => s.version }
s.source_files = 'Sources/AEAppVersion/*.swift'

s.swift_version = '4.2'

s.ios.deployment_target = '8.0'

s.homepage = 'https://github.com/tadija/AEAppVersion'
s.author = { 'tadija' => 'tadija@me.com' }
s.social_media_url = 'http://twitter.com/tadija'

end
