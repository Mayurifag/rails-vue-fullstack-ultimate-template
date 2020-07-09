# frozen_string_literal: true

return unless defined?(StrongMigrations)

StrongMigrations.auto_analyze = true

ActiveRecord::Base.dump_schema_after_migration =
  Rails.env.development? &&
  `git status db/migrate/ --porcelain`.present?
