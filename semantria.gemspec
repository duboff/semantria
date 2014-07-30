# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'semantria/version'

Gem::Specification.new do |spec|
  spec.name          = "semantria"
  spec.version       = Semantria::VERSION
  spec.authors       = ["Mikhail Dubov"]
  spec.email         = ["mdubov@gmail.com"]
  spec.summary       = "A more natural ruby interface for the Semantria API"
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = "http://github.com/duboff/semantria"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-remote"
  spec.add_development_dependency "pry-nav"
end
