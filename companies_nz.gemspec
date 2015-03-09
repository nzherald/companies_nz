# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'companies_nz/version'

Gem::Specification.new do |spec|
  spec.name          = 'companies_nz'
  spec.version       = CompaniesNZ::VERSION
  spec.authors       = ['Caleb']
  spec.email         = ['caleb.tutty@nzherald.co.nz']
  spec.summary       = %q{New Zealand Companies Office API wrapper}
  spec.description   = %q{This gem handles the HMAC SHA256 request signing required for the NZ Companies Office's API, using Faraday to make the request}
  spec.homepage      = 'http://github.com/nzherald/companies_nz'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_runtime_dependency 'faraday', '~> 0.9.1'
end
