$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require 'rspec/core/rake_task'
require "active_support"
require "mongoid"
require "mongoid_voteable"

task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

desc "Show version"
task :version do
  puts Mongoid::Voteable::VERSION
end

desc "Build gem"
task :build do
  system "gem build mongoid_voteable.gemspec"
end

desc "Install gem"
task :install => :build do
  system "sudo gem install mongoid_voteable-#{Mongoid::Voteable::VERSION}.gem"
end

desc "Release gem"
task :release => :build do
  puts "Tagging #{Mongoid::Voteable::VERSION}"
  system "git tag -a #{Mongoid::Voteable::VERSION} -m 'Tagging #{Mongoid::Voteable::VERSION}'"
  puts "Releasing to Gemcutter"
  system "gem push mongoid_voteable-#{Mongoid::Voteable::VERSION}.gem"
end