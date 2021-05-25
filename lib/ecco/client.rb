require "ext/mysql-binlog-connector-java-#{Ecco::MYSQL_BINLOG_CONNECTOR_VERSION}.jar"
require "ecco/row_event_listener"
require "ecco/save_event_listener"
require "ecco/lifecycle_failure_listener"
require "ecco/error"
require "forwardable"

module Ecco
  class Client
    DEFAULT_CONNECT_TIMEOUT = 3000 # ms

    extend Forwardable
    def_delegators :@client, :set_server_id, :get_server_id
    def_delegators :@client, :set_keep_alive, :is_keep_alive
    def_delegators :@client, :set_keep_alive_interval, :get_keep_alive_interval
    def_delegators :@client, :set_heartbeat_interval, :get_heartbeat_interval
    def_delegators :@client, :set_connect_timeout, :get_connect_timeout
    def_delegators :@client, :set_binlog_filename, :get_binlog_filename
    def_delegators :@client, :set_binlog_position, :get_binlog_position

    def get_keep_alive_connect_timeout
      warn "[DEPRECATION] `#{__method__}` is deprecated. "\
           "Please use `get_connect_timeout` instead."

      get_connect_timeout
    end

    def set_keep_alive_connect_timeout(timeout)
      warn "[DEPRECATION] `#{__method__}` is deprecated. "\
           "Please use `set_connect_timeout` instead."

      set_connect_timeout(timeout)
    end

    java_import com.github.shyiko.mysql.binlog.BinaryLogClient
    java_import java.io.IOException

    def initialize(hostname: "localhost", port: 3306, username:, password:)
      @client = BinaryLogClient.new(hostname, port, username, password)

      @row_event_listener  = RowEventListener.new(self)
      @client.register_event_listener(@row_event_listener)

      @save_event_listener = SaveEventListener.new(self)
      @client.register_event_listener(@save_event_listener)

      @lifecycle_failure_listener = LifecycleFailureListener.new
      @client.register_lifecycle_listener(@lifecycle_failure_listener)
    end

    def on_save_position(&block)
      @save_event_listener.callback = block
    end

    def on_row_event(&block)
      @row_event_listener.callback = block
    end

    def on_communication_failure(&block)
      @lifecycle_failure_listener.callback = block
    end

    def start
      @client.connect
    rescue IOException => e
      raise Ecco::Error::ConnectionError, e.get_message
    end

    def start_in_thread(connect_timeout: DEFAULT_CONNECT_TIMEOUT)
      @client.connect(connect_timeout)
    end

    def connected?
      @client.is_connected
    end

    def stop
      @client.disconnect
    end
  end
end
