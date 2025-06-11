source "https://rubygems.org"

ruby '3.4.4'

gem 'sinatra'
gem 'sinatra-contrib'
gem "rackup", "~> 2.2"
gem "puma", "~> 6.6"

gem "semantic_logger", "~> 4.16"

group :development do
  gem "rubocop", "~> 1.76"
  gem "dotenv", "~> 3.1"
  gem "pry", "~> 0.15.2"
end

group :tracing do
  gem "opentelemetry-sdk"
  gem "opentelemetry-exporter-otlp"
  gem "opentelemetry-instrumentation-sinatra"
end

group :database do
  gem "sequel"
  gem "pg"
  gem 'sequel_pg'
  gem 'rake'
end
