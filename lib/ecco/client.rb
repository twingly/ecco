require "ext/mysql-binlog-connector-java-#{Ecco::MYSQL_BINLOG_CONNECTOR_VERSION}.jar"
require "ecco/row_event_listener"
require "ecco/save_event_listener"
require "ecco/error"

module Ecco
  class Client
    DEFAULT_CONNECT_TIMEOUT = 3000 # ms

    extend Forwardable
    def_delegators :@client, :set_server_id, :get_server_id
    def_delegators :@client, :set_binlog_filename, :get_binlog_filename
    def_delegators :@client, :set_binlog_position, :get_binlog_position

    java_import com.github.shyiko.mysql.binlog.BinaryLogClient

    def initialize(hostname: "localhost", port: 3306, username:, password:)
      @client = BinaryLogClient.new(hostname, port, username, password)

      @save_event_listener = SaveEventListener.new(self)
      @client.register_event_listener(@save_event_listener)

      @row_event_listener  = RowEventListener.new(self)
      @client.register_event_listener(@row_event_listener)
    end

    def on_save_position(&block)
      @save_event_listener.callback = block
    end

    def on_row_event(&block)
      @row_event_listener.callback = block
    end

    def start
      @client.connect
    rescue java.io.IOException => e
      raise Ecco::Error::ConnectionError, e.get_message
    end

    def start_in_thread(connect_timeout: DEFAULT_CONNECT_TIMEOUT)
      @client.connect(connect_timeout)
    end

    def stop
      @client.disconnect
    end
  end
end
