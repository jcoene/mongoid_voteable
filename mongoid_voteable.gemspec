$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require "active_support"
require "mongoid"
require "mongoid/voteable"

Gem::Specification.new do |s|
  s.name        = "mongoid_voteable"
  s.version     = Mongoid::Voteable::VERSION
  s.authors     = ["Jason Coene"]
  s.email       = "jcoene@gmail.com"
  s.homepage    = "http://github.com/jcoene/mongoid_voteable"
  s.summary     = "Voting functionality for Mongoid models"
  s.description = "Provides fields and methods for the manipulation of votes on a Mongoid model."

  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency("mongoid",  [">= 2.0.0.beta.16"])
  s.add_dependency("activesupport", [">= 3.0.0.rc"])

  s.add_development_dependency("bson_ext", [">= 1.0.4"])
  s.add_development_dependency("rspec", [">= 2.0.0.beta.19"])
  s.add_development_dependency("database_cleaner", [">= 0.5.2"])

  s.files = Dir.glob("lib/**/*") + ["README.rdoc"]
  s.require_path = "lib"

end
