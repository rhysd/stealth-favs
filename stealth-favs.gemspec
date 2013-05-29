# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stealth_favs/version'

Gem::Specification.new do |spec|
  spec.name          = "stealth-favs"
  spec.version       = StealthFavs::VERSION
  spec.authors       = ["rhysd"]
  spec.email         = ["lin90162@yahoo.co.jp"]
  spec.description   = %q{Stealth favorites on Twitter.}
  spec.summary       = %q{Repeat fav and unfav many times on Twitter.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
