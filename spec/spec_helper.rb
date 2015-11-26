java_import java.util.logging.Logger
java_import java.util.logging.Level

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "ecco"

require_relative "client_context"
require_relative "event_context"

require_relative "test_helper"
require_relative "database_helper"

def set_java_root_logger_level(level)
  root_logger = Logger.get_logger("")

  # The first handler is by default the console
  root_logger.get_handlers.first.set_level(level)
end
