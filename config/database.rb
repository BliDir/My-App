# frozen_string_literal: true

require 'sequel'
require 'pg'
require_relative '../config/app_config'

DB = Sequel.connect(
  adapter: 'postgres',
  host: AppConfig::Database::DB_HOST,
  port: AppConfig::Database::DB_PORT,
  database: AppConfig::Database::DB_NAME,
  user: AppConfig::Database::DB_USERNAME,
  password: AppConfig::Database::DB_PASSWORD
)
