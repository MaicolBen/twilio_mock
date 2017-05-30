Gem::Specification.new do |s|
  s.name        = 'twilio-mock'
  s.version     = '0.0.1'
  s.date        = '2017-05-30'
  s.summary     = 'Mock for the twilio gem'
  s.description = 'ock for the twilio gem using webmock'
  s.authors     = ['Maicol Bentancor']
  s.files       = Dir['lib/**/*.rb']
  s.license       = 'MIT'

  s.add_dependency 'twilio-ruby', '~> 4.13', '>= 4.13.0'
end
