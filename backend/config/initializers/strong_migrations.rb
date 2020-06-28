# frozen_string_literal: true

return unless defined?(StrongMigrations)

# Start after 2020-06-01 00:00:00 - after first migration with initial db tables creation
StrongMigrations.start_after = 2020_05_01_00_00_00

StrongMigrations.auto_analyze = true

ActiveRecord::Base.dump_schema_after_migration =
  Rails.env.development? &&
  `git status db/migrate/ --porcelain`.present?
