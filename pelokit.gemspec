# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pelokit/version'

Gem::Specification.new do |spec|
  spec.name          = "pelokit"
  spec.version       = Pelokit::VERSION
  spec.authors       = ["Dave Liggat"]
  spec.email         = ["dliggat@peloton-technologies.com"]
  spec.summary       = "A gem to interact with Peloton Technologies' APIs"
  spec.homepage      = "http://peloton-technologies.com"
  spec.license       = "MIT"

  spec.files         = Dir["{lib}/*.rb", "bin/*", "*.md", "{lib/dir_manifest}/*.rb"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "fuubar", "~> 2.0"
  spec.add_dependency "activesupport"
  spec.add_dependency "activemodel"
  spec.add_dependency "hashie"
  spec.add_dependency "savon", "~> 2.11.0"
end
