Pod::Spec.new do |s|
	s.name = 'AEAppVersion'
	s.version = '0.3.2'
	s.summary = 'Dead Simple App Version Tracking for iOS'

	s.homepage = 'https://github.com/tadija/AEAppVersion'
	s.license = { :type => 'MIT', :file => 'LICENSE' }
	s.author = { 'tadija' => 'tadija@me.com' }
	s.social_media_url = 'http://twitter.com/tadija'

	s.ios.deployment_target = '8.0'

	s.source = { :git => 'https://github.com/tadija/AEAppVersion.git', :tag => s.version }
    s.source_files = 'Sources/*.swift'
end