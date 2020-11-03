require "ecco/event_listener"

module Ecco
  class SaveEventListener < EventListener
    def initialize(client)
      super(client)
      @events = {
        EventType::QUERY  => "QUERY",
        EventType::ROTATE => "ROTATE"
      }.merge(@events)
    end

    def on_event(event)
      type = event.get_header.get_event_type
      case type
      when *accepted_events
        filename        = @client.get_binlog_filename
        position        = @client.get_binlog_position
        event_type_name = fetch_event(type)

        @callback.call(filename, position, event_type_name)
      end
    end
  end
end
