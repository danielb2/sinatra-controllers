require 'bundler'
require 'rake/testtask'
Bundler::GemHelper.install_tasks

Rake::TestTask.new :test do |spec|
    spec.test_files = FileList["test/*_test.rb"]
end
