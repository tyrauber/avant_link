$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "avant_link/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "avant_link"
  s.version     = AvantLink::VERSION
  s.authors     = ["Ty Rauber"]
  s.email       = ["tyrauber@mac.com"]
  s.homepage    = "https://github.com/tyrauber/avant_link"
  s.summary     = "AvantLink Ruby Gem"
  s.description = "AvantLink Ruby Gem"
  s.license     = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  # specify any dependencies here; for example:

  s.add_runtime_dependency 'http'
  s.add_runtime_dependency 'crack'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'webmock', '< 2.0'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'rubocop'
end
