Pod::Spec.new do |s|
  s.name         	= "MOAspects"
  s.version      	= "0.0.1"
  s.summary      	= "AOP Library."
  s.homepage     	= "https://github.com/MO-AI/MOAspects"
  s.license      	= 'MIT'
  s.author       	= { "Hiromi Motodera" => "moai.motodera@gmail.com" }
  s.source       	= { :git => "https://github.com//MO-AI/MOAspects.git", :tag => "#{s.version}" }
  s.public_header_files = 'MOAspects/*.h'
  s.source_files = 'MOAspects/MOAspects.h'
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.8"
  s.requires_arc 	= true
end
