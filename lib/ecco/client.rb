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

    attr_reader :on_row_event_callback, :on_save_position_callback

    def initialize(hostname: "localhost", port: 3306, username:, password:)
      @client = BinaryLogClient.new(hostname, port, username, password)
      @client.register_event_listener(SaveEventListener.new(self))
      @client.register_event_listener(RowEventListener.new(self))

      @on_row_event_callback     = Proc.new {}
      @on_save_position_callback = Proc.new {}
    end

    def on_row_event(&block)
      @on_row_event_callback = block
    end

    def on_save_position(&block)
      @on_save_position_callback = block
    end

    def start
      @client.connect
    end
  end
end
