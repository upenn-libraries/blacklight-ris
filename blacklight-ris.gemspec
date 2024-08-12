$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "blacklight/ris/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "blacklight-ris"
  s.version     = Blacklight::Ris::VERSION
  s.authors     = ["Jeff Chiu"]
  s.email       = ["jeffchiu@upenn.edu"]
  s.homepage    = "https://github.com/upenn-libraries/blacklight-ris"
  s.summary     = "RIS format export for Blacklight"
  s.description = "RIS format export for Blacklight"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", '>= 7'
  s.add_dependency "blacklight",  '>= 7'

  s.metadata['rubygems_mfa_required'] = 'false'
end
