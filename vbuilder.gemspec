# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vbuilder/version'

Gem::Specification.new do |spec|
  spec.name          = "vbuilder"
  spec.version       = Vbuilder::Version.version
  spec.authors       = ["Ian DesJardins"]
  spec.email         = ["ian.d.desjardins@gmail.com"]

  spec.description   = %q{Easily create your Vagrantfiles based on the given provider}
  spec.summary       = %q{Create Vagrantfiles}
  spec.homepage      = "https://github.com/iandesj/vbuilder"

  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["vbuilder"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "highline", "~> 1.7", ">= 1.7.8"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 2.99"

  spec.required_ruby_version = ">= 2.0"
end
