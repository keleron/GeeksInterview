# frozen_string_literal: true

require "bundler/gem_tasks"
require "rubocop/rake_task"
require "rspec/core/rake_task"

# Define the RSpec task
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "spec/**/*_spec.rb" # You can adjust this pattern to match your spec file locations
end

# Define the RuboCop task
RuboCop::RakeTask.new

# Define the default task
task default: %i[spec rubocop]
