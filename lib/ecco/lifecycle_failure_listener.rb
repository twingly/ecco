module Ecco
  class LifecycleFailureListener < com.github.shyiko.mysql.binlog.BinaryLogClient::AbstractLifecycleListener
    attr_writer :callback

    def initialize
      @callback = Proc.new {}
    end

    def onCommunicationFailure(client, exception)
      error = Ecco::Error::CommunicationError.new(exception.get_message)
      @callback.call(client, error)
    end
  end
end
