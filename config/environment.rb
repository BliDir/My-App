require 'dotenv/load' if ENV['RACK_ENV'] == 'development'

require 'bundler/setup'
require 'sinatra'
require_relative '../config/logger'
require_relative '../config/database'

Bundler.require(:default)