require "ecco/event_listener"

module Ecco
  class SaveEventListener < EventListener
    def initialize(client)
      super(client, events_of_interest)
    end

    def on_event(event)
      type = event.get_header.get_event_type
      case type
      when *accepted_events
        filename        = @client.get_binlog_filename
        position        = @client.get_binlog_position
        event_type_name = event_type_to_string(type)

        @callback.call(filename, position, event_type_name)
      end
    end

    private

    def events_of_interest
      [WRITE_EVENTS, UPDATE_EVENTS, DELETE_EVENTS, QUERY_EVENTS, ROTATE_EVENTS]
    end
  end
end
