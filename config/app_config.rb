# frozen_string_literal: true

module AppConfig
  # Configuration for application tracing functionality
  module Tracing
    TRACING_ENABLED = ENV.fetch('TRACING_ENABLED', 'false') == 'true'
    JAEGER_SERVICE_NAME = ENV.fetch('JAEGER_SERVICE_NAME', 'My-App')
    OTEL_EXPORTER_OTLP_ENDPOINT = ENV.fetch('OTEL_EXPORTER_OTLP_ENDPOINT', 'http://localhost:4317')
  end

  # Configuration for database functionality
  module Database
    DB_USERNAME = ENV.fetch('DB_USERNAME', 'postgres')
    DB_PASSWORD = ENV.fetch('DB_PASSWORD', 'postgres')
    DB_HOST = ENV.fetch('DB_HOST', 'localhost')
    DB_PORT = ENV.fetch('DB_PORT', 5432)
    DB_NAME = ENV.fetch('DB_NAME', 'my_app')
  end
end
