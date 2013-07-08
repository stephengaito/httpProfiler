# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'httpTimer/version'

Gem::Specification.new do |spec|
  spec.name          = "httpTimer"
  spec.version       = HttpTimer::VERSION
  spec.authors       = ["Stephen Gaito"]
  spec.email         = ["stephen@perceptisys.co.uk"]
  spec.description = %q{Run simple (sequencial) tests on a collection 
of urls to determine average, stardard deviation and median connection 
times}
  spec.summary = %q{Run simple (sequential) tests on a collection of 
urls}
  spec.homepage      = "https://github.com/stephengaito/httpTimer"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "bundler", "~> 1.3"
  spec.add_dependency "curb"
  spec.add_dependency "floatstats"
end
