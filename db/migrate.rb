# frozen_string_literal: true

require 'sequel'
require 'sequel/extensions/migration'
require_relative '../config/database'

Sequel.extension :migration

Sequel.Migrator.run(DB, File.expand_path('../../db/migrations', __dir__))
