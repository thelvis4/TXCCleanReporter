Pod::Spec.new do |s|  
  s.name         = "TXCCleanReporter"
  s.version      = "0.0.3"
  s.summary      = "Bettet way to display tests response"
  s.homepage     = "http://EXAMPLE/TXCCleanReporter"
  s.author       = { "Andrei Raifura" => "thelvis4@gmail.com" }
  s.platform     = :ios, '7.0'
  s.source_files  = 'CleanTestsObserver', 'CleanTestsObserver/*.{h,m}'
  s.public_header_files = 'CleanTestsObserver', 'CleanTestsObserver/*.{h}'
  s.requires_arc = true
  s.framework    = 'XCTest'

end 