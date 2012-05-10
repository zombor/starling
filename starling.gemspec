lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'starling/version'

Gem::Specification.new do |s|
	s.name = 'starling.gem'
	s.version = Starling::VERSION
	s.authors = ['Jeremy Bush']
	s.email = ['contractfrombelow@gmail.com']
	s.homepage = 'https://github.com/zombor/starling'
	s.summary = 'Easy to use twitter cli client'

	#s.add_dependency('i18n', '0.6.0')

	s.files = Dir['lib/**/*.rb']
	s.files.reject! { |fn| fn.include? 'version.rb' }
	s.require_path = 'lib'
end
