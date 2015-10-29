module Ecco
  class EventListener
    include com.github.shyiko.mysql.binlog.BinaryLogClient::EventListener
    java_import com.github.shyiko.mysql.binlog.event.EventType

    attr_writer :callback

    def initialize(client)
      @client  = client
      @callback = Proc.new {}
    end

    def on_event(event)
      raise NotImplementedError
    end
  end
end
