module Ecco
  class EventListener
    include com.github.shyiko.mysql.binlog.BinaryLogClient::EventListener
    java_import com.github.shyiko.mysql.binlog.event.EventType

    def initialize(client)
      @client = client
    end

    def on_event(event)
      @data = event.get_data
      @type = event.get_header.get_event_type
    end
  end
end
