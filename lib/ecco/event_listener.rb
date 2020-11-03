module Ecco
  class EventListener
    include com.github.shyiko.mysql.binlog.BinaryLogClient::EventListener
    java_import com.github.shyiko.mysql.binlog.event.EventType

    attr_writer :callback

    def initialize(client)
      @client = client
      @callback = Proc.new {}
      @events = {
        EventType::WRITE_ROWS      => "WRITE_ROWS",
        EventType::EXT_WRITE_ROWS  => "WRITE_ROWS",
        EventType::UPDATE_ROWS     => "UPDATE_ROWS",
        EventType::EXT_UPDATE_ROWS => "UPDATE_ROWS",
        EventType::DELETE_ROWS     => "DELETE_ROWS",
        EventType::EXT_DELETE_ROWS => "DELETE_ROWS"
      }
    end

    TABLE_EVENT = EventType::TABLE_MAP

    def on_event(event)
      raise NotImplementedError
    end

    def accepted_events
      @events.keys
    end

    def fetch_event(type)
      @events.fetch(type)
    end
  end
end
