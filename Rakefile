namespace :style do
  require 'foodcritic'
  desc 'Run the foodcritic linting'

  FoodCritic::Rake::LintTask.new(:foodcritic) do |task|
    task.options = { exclude: 'test/ cookbooks/' }
  end

  require 'rubocop/rake_task'
  require 'cookstyle'
  # failing only on severity ERROR and FAIL
  RuboCop::RakeTask.new(:rubocop) do |task|
    task.options = ['--fail-level', 'E']
  end
end
# Alias
task style: %w(style:foodcritic style:rubocop)

# Unit tests with rspec
namespace :unit do
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:rspec) do |task|
    task.rspec_opts = '--format documentation'
  end
end
# Alias
task unit: ['unit:rspec']

# Running kitchen in the following way assures that all dependend cookbooks are stored inside the local working directory and that they are being downloaded everytime this rake task is being triggered. This is to prevent tests to fail because of it using outdated dependend cookbooks
desc 'Preperation steps for kitchen integration tests'
task :integration do
  sh %( rm -rf cookbooks config.json)
  sh %( wget -q http://z-de-qa01.zanox.com/berkshelf/config.json )
  sh %( while BERKSHELF_PATH='.' berks update | grep Installing; do sleep 0.1; done )
  sh %( BERKSHELF_PATH='.' kitchen test --destroy=always )
  sh %( rm -rf cookbooks config.json)
end

# Alias
task int: %w(integration)

desc 'Run full test stack'
task test: %w(style unit integration)

task default: %w(style unit)
