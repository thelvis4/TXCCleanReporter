Pod::Spec.new do |s|  
  s.name         = "TXCCleanReporter"
  s.version      = "0.0.1"
  s.summary      = "Better way to display tests response"
  s.homepage     = "https://github.com/thelvis4/TXCCleanReporter"
  s.author       = { "Andrei Raifura" => "thelvis4@gmail.com" }
  s.platform     = :ios, '7.0'
  s.source_files  = 'CleanTestsObserver', 'CleanTestsObserver/*.{h,m}'
  s.public_header_files = 'CleanTestsObserver', 'CleanTestsObserver/*.{h}'
  s.requires_arc = true
  s.framework    = 'XCTest'

end 