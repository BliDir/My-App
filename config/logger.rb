require "semantic_logger"

SemanticLogger.add_appender(
  io: $stdout,
  level: :info,
  formatter: :json
)

LOGGER = SemanticLogger["App"]