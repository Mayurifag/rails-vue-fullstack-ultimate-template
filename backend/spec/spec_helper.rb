# frozen_string_literal: true

require "shoulda/matchers"
require "zonebie/rspec"
require "webmock/rspec"
require "simplecov"

if ENV["TEST_ENV_NUMBER"]
  require "simplecov-console"
  SimpleCov.formatter = SimpleCov::Formatter::Console
  SimpleCov.at_exit do
    result = SimpleCov.result
    result.format! if ParallelTests.number_of_running_processes <= 1
  end
end
SimpleCov.start "rails"

WebMock.disable_net_connect!(allow: [])

RSpec.configure do |config|
  config.add_formatter "Fuubar"
  config.filter_run_when_matching :focus
  config.disable_monkey_patching!
  config.default_formatter = "doc" if config.files_to_run.one?
  config.profile_examples = 4
  config.order = :random
  Kernel.srand config.seed

  config.example_status_persistence_file_path = "tmp/rspec_examples.txt"
end
