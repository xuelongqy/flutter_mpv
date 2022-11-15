#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_mpv.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_mpv'
  s.version          = '0.0.1'
  s.summary          = 'Mpv player for Flutter.'
  s.description      = <<-DESC
Mpv player for Flutter.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }

  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  # Node
  s.vendored_libraries = 'Frameworks/libmpv.dylib'

  s.platform = :osx, '10.13'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
