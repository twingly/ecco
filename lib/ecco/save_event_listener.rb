require "ecco/event_listener"
require_relative "row_type"

module Ecco
  class SaveEventListener < EventListener
    def on_event(event)
      type = event.get_header.get_event_type

      case type
      when *Ecco::RowTypeSave.accepted_events
        filename        = @client.get_binlog_filename
        position        = @client.get_binlog_position
        event_type_name = Ecco::RowTypeSave.fetch_event(type)

        @callback.call(filename, position, event_type_name)
      end
    end
  end
end
