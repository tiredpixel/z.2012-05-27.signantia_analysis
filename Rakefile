require 'rake'
require 'rspec/core/rake_task'

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.rspec_opts = "--color --format nested"
end

task :default => :spec
