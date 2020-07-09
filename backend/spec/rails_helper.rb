# frozen_string_literal: true

require "spec_helper"
ENV["RAILS_ENV"] = "test"
require File.expand_path("../config/environment", __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

require "rspec/rails"
require "simplecov"

# parallel specs
if ENV["TEST_ENV_NUMBER"]
  require "simplecov-console"
  SimpleCov.formatter = SimpleCov::Formatter::Console
  SimpleCov.at_exit do
    result = SimpleCov.result
    result.format! if ParallelTests.number_of_running_processes <= 1
  end
end
SimpleCov.start "rails"

Dir[Rails.root.join("spec", "support", "**", "*.rb")].sort.each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => exception
  puts exception.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include JsonHelper
  config.include AuthHelper

  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = true
  config.filter_rails_from_backtrace!
  config.silence_filter_announcements = true if ENV["TEST_ENV_NUMBER"]
end
