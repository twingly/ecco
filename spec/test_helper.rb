require "timeout"

class TestHelper
  CLIENT_TIMEOUT = 10 # seconds

  def self.get_row_events_from_client(ecco_client, count: 1, &block)
    received_row_events = []

    ecco_client.on_row_event do |row_event|
      received_row_events << row_event
      ecco_client.stop if received_row_events.count == count
    end

    start_client_in_thread_and_run_block(ecco_client, &block)

    count == 1 ? received_row_events.first : received_row_events
  end

  def self.get_save_position_events_from_client(ecco_client, count: 1, &block)
    received_save_position_events = []

    ecco_client.on_save_position do |filename, position|
      received_save_position_events << {
        filename: filename,
        position: position,
      }
      ecco_client.stop if received_save_position_events.count == count
    end

    start_client_in_thread_and_run_block(ecco_client, &block)

    count == 1 ? received_save_position_events.first : received_save_position_events
  end

  def self.start_client_in_thread_and_run_block(ecco_client)
    Timeout.timeout(CLIENT_TIMEOUT) do
      thread = Thread.new do |t|
        ecco_client.start
      end

      sleep 1

      yield if block_given?

      thread.join
    end
  rescue Timeout::Error => exception
    raise exception, "No binlog events received"
  end

  private_class_method :start_client_in_thread_and_run_block
end
