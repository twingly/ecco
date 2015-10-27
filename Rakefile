require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :maven do
  desc "Download dependencies specified in pom.xml"
  task :dependencies do
    system("mvn dependency:copy-dependencies -DoutputDirectory=lib/ext")
  end
end
