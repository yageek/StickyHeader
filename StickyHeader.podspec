Pod::Spec.new do |s|

  s.name         = "StickyHeader"
  s.version      = "1.0.1"
  s.summary      = "Library helping to add a sticky header to an UIScrollView."
  s.description  = <<-DESC
  Library helping to add a sticky header to an UIScrollView.
  The code is based on https://github.com/maxep/MXParallaxHeader.
                   DESC
  s.homepage     = "https://github.com/yageek/StickyHeader"
  s.license      = "MIT"
  s.author             = { "Yannick Heinrich" => "yannick.heinrich@gmail.com" }
  s.source       = { :git => "https://github.com/yageek/StickyHeader.git", :tag => "#{s.version}" }
  s.source_files  = "StickyHeader"
  s.platform = :ios
  s.ios.deployment_target = '8.0'
end

