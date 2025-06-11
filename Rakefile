# frozen_string_literal: true

require 'sequel'
require_relative 'config/database'

namespace :db do
  desc 'Run all migrations'
  task :migrate do
    Sequel.extension :migration
    Sequel::Migrator.run(DB, 'db/migrations')
    puts '✅ Migrations complete'
  end
end
