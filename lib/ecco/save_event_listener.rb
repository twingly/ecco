require "ecco/event_listener"

module Ecco
  class SaveEventListener < EventListener
    def initialize(client)
      events_of_interest = retrieve_save_events
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

    def retrieve_save_events
      Hash.new.merge(WRITE_EVENTS)
              .merge(UPDATE_EVENTS)
              .merge(DELETE_EVENTS)
              .merge(QUERY_EVENTS)
              .merge(ROTATE_EVENTS)
    end
  end
end
