Gem::Specification.new do |s|
  s.name        = 'twilio_mock'
  s.version     = '0.1.0'
  s.date        = '2017-05-30'
  s.summary     = 'Mock for the twilio gem'
  s.description = 'Mock for the twilio gem using webmock'
  s.authors     = ['Maicol Bentancor']
  s.files       = Dir['lib/**/*.rb']
  s.license       = 'MIT'

  s.add_dependency 'twilio-ruby', '~> 4.13', '>= 3'
  s.add_dependency 'webmock', '~> 3.0', '>= 2 '
end
