Gem::Specification.new do |s|
  s.name        = 'twilio_mock'
  s.version     = '0.3.0'
  s.date        = '2017-10-07'
  s.summary     = 'Mock for the twilio gem'
  s.description = 'Mock for the twilio gem using webmock'
  s.authors     = ['Maicol Bentancor']
  s.files       = Dir['lib/**/*.rb']
  s.license       = 'MIT'

  s.add_dependency 'twilio-ruby', '~> 5.2.3', '>= 5'
  s.add_dependency 'webmock', '~> 3.0', '>= 2'
end
