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

    def on_event(event)
      case event.get_header.get_event_type
      when *SAVE_EVENTS
        filename = @client.get_binlog_filename
        position = @client.get_binlog_position

        @callback.call(filename, position)
      end
    end
  end
end
