Pod::Spec.new do |spec|
  spec.name         = "ImageTransition"
  spec.version      = "0.3.0"
  spec.summary      = "ImageTransition is a library for smooth animation of images during transitions."
  spec.homepage     = "https://github.com/shtnkgm/ImageTransition"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author         = "shtnkgm"
  spec.platform       = :ios, "9.0"
  spec.swift_version  = "4.2"
  spec.source         = { :git => "https://github.com/shtnkgm/ImageTransition.git", :tag => "#{spec.version}" }
  spec.source_files   = "ImageTransition/**/*.swift"
end
