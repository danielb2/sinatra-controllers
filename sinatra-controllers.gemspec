# -*- encoding: utf-8 -*-
require File.expand_path("../lib/sinatra-controllers/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "sinatra-controllers"
  s.version     = Sinatra::Controllers::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Daniel Bretoi']
  s.email       = []
  s.homepage    = "http://rubygems.org/gems/sinatra-controllers"
  s.summary     = "Adds controllers to Sinatra"
  s.description = "Adds controllers to Sinatra"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "sinatra-controllers"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "minitest", "~> 2.0.0"
  s.add_development_dependency "watchr"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
  s.test_files   = `git ls-files -- {test,spec,features}/*`.split("\n")
end
