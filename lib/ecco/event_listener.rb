module Ecco
  class EventListener
    include com.github.shyiko.mysql.binlog.BinaryLogClient::EventListener
    java_import com.github.shyiko.mysql.binlog.event.EventType

    WRITE_EVENTS  = { EventType::WRITE_ROWS => "WRITE_ROWS", EventType::EXT_WRITE_ROWS => "WRITE_ROWS" }
    UPDATE_EVENTS = { EventType::UPDATE_ROWS => "UPDATE_ROWS", EventType::EXT_UPDATE_ROWS => "UPDATE_ROWS" }
    DELETE_EVENTS = { EventType::DELETE_ROWS => "DELETE_ROWS" , EventType::EXT_DELETE_ROWS => "DELETE_ROWS" }
    QUERY_EVENTS  = { EventType::QUERY => "QUERY"}
    ROTATE_EVENTS = { EventType::ROTATE => "ROTATE"}

    TABLE_EVENT = EventType::TABLE_MAP

    attr_writer :callback

    def initialize(client, events_of_interest)
      @client = client

      @events_of_interest = events_of_interest.reduce(&:merge)
      @accepted_events = @events_of_interest.keys

      @callback = Proc.new {}
    end

    def on_event(event)
      raise NotImplementedError
    end

    def accepted_events
      @accepted_events
    end

    def event_type_to_string(type)
      @events_of_interest.fetch(type)
    end
  end
end
