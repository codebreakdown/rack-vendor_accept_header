# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/vendor_accept_header/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-vendor_accept_header"
  spec.version       = Rack::VendorAcceptHeader::VERSION
  spec.authors       = ["Andrew De Ponte"]
  spec.email         = ["cyphactor@gmail.com"]

  spec.summary       = %q{Rack middleware to parse vendor accept headers}
  spec.description   = %q{Rack middleware to aid with parsing vendor accept headers}
  spec.homepage      = "https://github.com/codebreakdown/rack-vendor_accept_header"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rack", "~> 1.6"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
  spec.add_development_dependency "rack-test", "~> 0.6"
end
