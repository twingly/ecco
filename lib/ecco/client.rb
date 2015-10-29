require "ext/mysql-binlog-connector-java-#{Ecco::MYSQL_BINLOG_CONNECTOR_VERSION}.jar"
require "ecco/row_event_listener"
require "ecco/save_event_listener"

module Ecco
  class Client
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
    end
  end
end
