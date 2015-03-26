Pod::Spec.new do |s|
  s.name         	= "MOAspects"
  s.version      	= "0.0.1"
  s.summary      	= "AOP Library."
  s.homepage     	= "https://github.com/MO-AI/MOAspects"
  s.license      	= 'MIT'
  s.author       	= { "Hiromi Motodera" => "moai.motodera@gmail.com" }
  s.source       	= { :git => "https://github.com/MO-AI/MOAspects.git", :tag => "#{s.version}", :submodules => true }
  s.public_header_files = 'MOAspects/*.h'
  s.source_files = 'MOAspects/MOAspects.h'
  s.ios.deployment_target = "6.0"
  s.osx.deployment_target = "10.8"
  s.requires_arc 	= true

  s.subspec 'AspectsTarget' do |ss|
      ss.source_files = 'MOAspects/MOAspects{Target,Store}.{h,m}'
  end

  s.subspec 'Runtime' do |ss|
      ss.source_files = 'MOAspects/MOARuntime.{h,m}'
  end
end
