# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "version"

Gem::Specification.new do |s|
  s.name        = "sendgrid_webapi"
  s.version     = SendGridWebApi::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["kylejginavan", "chebyte"]
  s.email       = ["kylejginavan@gmail.com", "maurotorres@gmail.com"]
  s.homepage    = "https://github.com/kylejginavan/sendgrid_webapi"
  s.summary     = %q{SendGrid WEB API gem fo Rails}
  s.description = %q{Gem for access to SendGrid WEB API from rails}
  s.license     = "MIT"

  s.rubyforge_project = "sendgrid_webapi"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "faraday",          "~> 1.0"
  s.add_dependency "faraday_middleware",  "~> 1.0"
  s.add_dependency "json", "~> 2.0"

  s.add_development_dependency "rspec", "~> 3.4"
  s.add_development_dependency "webmock", "~> 3.12"
  s.add_development_dependency "vcr", "~> 6.0"
  s.add_development_dependency "rspec_junit_formatter",   "~> 0.3", ">= 0.3.0"
end
