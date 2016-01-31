Pod::Spec.new do |s|
s.name = 'AEAppVersionManager'
s.version = '0.1.0'
s.license = { :type => 'MIT', :file => 'LICENSE' }
s.summary = 'Simple and Lightweight App Version Tracking'

s.homepage = 'https://github.com/tadija/AEAppVersionManager'
s.author = { 'tadija' => 'tadija@me.com' }
s.social_media_url = 'http://twitter.com/tadija'

s.source = { :git => 'https://github.com/tadija/AEAppVersionManager.git', :tag => s.version }
s.source_files = 'Source/*.swift'

s.ios.deployment_target = '8.0'
s.osx.deployment_target = '10.10'
s.tvos.deployment_target = '9.0'
s.watchos.deployment_target = '2.0'
end