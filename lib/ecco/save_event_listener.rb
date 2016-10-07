require "ecco/event_listener"

module Ecco
  class SaveEventListener < EventListener
    SAVE_EVENTS = {
      EventType::QUERY           => "QUERY",
      EventType::ROTATE          => "ROTATE",
      EventType::WRITE_ROWS      => "WRITE_ROWS",
      EventType::EXT_WRITE_ROWS  => "WRITE_ROWS",
      EventType::UPDATE_ROWS     => "UPDATE_ROWS",
      EventType::EXT_UPDATE_ROWS => "UPDATE_ROWS",
      EventType::DELETE_ROWS     => "DELETE_ROWS",
      EventType::EXT_DELETE_ROWS => "DELETE_ROWS",
    }

    def accepted_events
      SAVE_EVENTS.keys
    end

    def on_event(event)
      type = event.get_header.get_event_type

      case type
      when *accepted_events
        filename        = @client.get_binlog_filename
        position        = @client.get_binlog_position
        event_type_name = SAVE_EVENTS.fetch(type)

        @callback.call(filename, position, event_type_name)
      end
    end
  end
end
