require 'rake/clean'
require 'rspec/core/rake_task'

CLEAN.include ["**/*~", "**/*.bak", "**/core", './coverage']

RSpec::Core::RakeTask.new(:spec) do |t| 
  t.pattern = './test/specs/*_spec.rb'
end

task :default => :spec
