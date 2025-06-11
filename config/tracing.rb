# frozen_string_literal: true

require 'opentelemetry'
require 'opentelemetry/sdk'
require 'opentelemetry/exporter/otlp'
require_relative '../config/app_config'

if AppConfig::Tracing::TRACING_ENABLED
  OpenTelemetry::SDK.configure do |c|
    c.service_name = AppConfig::Tracing::JAEGER_SERVICE_NAME
    c.use_all
    c.add_span_processor(
      OpenTelemetry::SDK::Trace::Export::BatchSpanProcessor.new(
        OpenTelemetry::Exporter::OTLP::SpanExporter.new(
          endpoint: AppConfig::Tracing::OTEL_EXPORTER_OTLP_ENDPOINT,
          insecure: true
        )
      )
    )
  end
else
  LOGGER.info('Tracing is disabled')
  # Initialize a no-op tracer provider
  OpenTelemetry::SDK::Trace::TracerProvider.new
end
