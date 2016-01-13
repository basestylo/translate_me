# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'translate_me/version'

Gem::Specification.new do |spec|
  spec.name          = "translate_me"
  spec.version       = TranslateMe::VERSION
  spec.authors       = ["David Martin Garcia"]
  spec.email         = ["base.dks@gmail.com"]

  spec.summary       = %q{Google translate for dummies.}
  spec.description   = %q{With this gem you can translate with Google Translate API.}
  spec.homepage      = "https://github.com/basestylo/translate_me."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "typhoeus", "> 0.7"
  spec.add_dependency 'nokogiri', '> 1.5'
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", '~> 3.0'
end
