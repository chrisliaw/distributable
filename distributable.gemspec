$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "distributable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "distributable"
  s.version     = Distributable::VERSION
  s.authors     = ["Chris Liaw"]
  s.email       = ["chrisliaw@antrapol.com"]
  s.homepage    = ""
  s.summary     = ""
  s.description = ""
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "> 4.0.0"

  s.add_development_dependency "sqlite3"
end
