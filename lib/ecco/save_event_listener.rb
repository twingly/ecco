require "ecco/event_listener"

module Ecco
  class SaveEventListener < EventListener
    SAVE_EVENTS = [
      EventType::QUERY,
      EventType::ROTATE,
      EventType::WRITE_ROWS,
      EventType::UPDATE_ROWS,
      EventType::DELETE_ROWS,
    ]

    def accepted_events
      SAVE_EVENTS
    end

    def on_event(event)
      type = event.get_header.get_event_type

      case type
      when *accepted_events
        filename = @client.get_binlog_filename
        position = @client.get_binlog_position

        @callback.call(filename, position)
      end
    end
  end
end
