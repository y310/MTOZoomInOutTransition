Pod::Spec.new do |s|
  s.name             = "MTOZoomInOutTransition"
  s.version          = "0.1.0"
  s.summary          = "A zoom in/out animator for iOS7 Custom Transition"
  s.description      = <<-DESC
                       A zoom in/out animator for iOS7 Custom Transition.
                       DESC
  s.homepage         = "https://github.com/y310/MTOZoomInOutTransition"
  s.screenshots      = ""
  s.license          = 'MIT'
  s.author           = { "Yusuke Mito" => "y310.1984@gmail.com" }
  s.source           = { :git => "https://github.com/y310/MTOZoomInOutTransition", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/y_310'

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source_files = 'Classes/**/*.{h,m}'
  s.resources = 'Assets'
end
