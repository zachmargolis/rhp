# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rhp/version'

Gem::Specification.new do |spec|
  spec.name          = 'rhp'
  spec.version       = RHP::VERSION
  spec.authors       = ['Zach Margolis']
  spec.email         = ['zbmargolis@gmail.com']
  spec.summary       = %q{RHP: Ruby Hypertext Preprocessor}
  spec.description   = %q{A PHP-like HTML templating environment in Ruby.}
  spec.homepage      = 'https://github.com/zachmargolis/rhp'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'rack', '>= 1.5'
  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
end
  