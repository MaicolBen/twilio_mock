Gem::Specification.new do |s|
  s.name        = 'twilio_mock'
  s.version     = '0.4.7'
  s.date        = '2018-08-30'
  s.summary     = 'Mock for the twilio gem'
  s.description = 'Mock for the twilio gem using webmock'
  s.authors     = ['Maicol Bentancor']
  s.files       = Dir['lib/**/*.rb']
  s.license       = 'MIT'
  s.required_ruby_version = '>= 2.2'

  s.add_dependency 'twilio-ruby', '~> 5.3', '>= 5.3.1'
  s.add_dependency 'webmock', '~> 3.0', '>= 2'
  s.add_dependency 'activesupport', '>= 3', '>= 3'
end
