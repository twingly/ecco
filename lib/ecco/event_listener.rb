module Ecco
  class EventListener
    include com.github.shyiko.mysql.binlog.BinaryLogClient::EventListener
    java_import com.github.shyiko.mysql.binlog.event.EventType

    attr_accessor :callback
    def initialize(client)
      @client  = client
      callback = Proc.new {}
    end

    def on_event(event)
      @data = event.get_data
      @type = event.get_header.get_event_type
    end
  end
end
