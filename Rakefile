require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) do |task|
  task.exclude_pattern = "spec/integration/*_spec.rb"
end

namespace :spec do
  RSpec::Core::RakeTask.new(:all)
end

task :default => :spec

namespace :maven do
  desc "Download dependencies specified in pom.xml"
  task :dependencies do
    system("mvn dependency:copy-dependencies -DoutputDirectory=lib/ext")
  end
end
