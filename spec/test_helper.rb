require "timeout"

class TestHelper
  CLIENT_TIMEOUT = 10 # seconds
  SLEEP_TIME     = 0.1

  def self.wait_for_row_events(ecco_client, count: 1, &block)
    with_timeout do
      received_events = []

      ecco_client.on_row_event do |row_event|
        received_events << row_event
      end

      ecco_client.start_in_thread
      block.call if block_given?

      sleep SLEEP_TIME while received_events.count < count

      received_events
    end
  ensure
    ecco_client.stop
  end

  def self.wait_for_save_position_events(ecco_client, count: 1, &block)
    # Take into account the initial save event that is emitted when client starts
    count += 1

    with_timeout do
      received_events = []

      ecco_client.on_save_position do |filename, position|
        received_events << {
          filename: filename,
          position: position,
        }
      end

      ecco_client.start_in_thread
      block.call if block_given?

      sleep SLEEP_TIME while received_events.count < count

      # Remove the initial save event
      received_events.shift

      received_events
    end
  ensure
    ecco_client.stop
  end

  def self.with_timeout
    Timeout.timeout(CLIENT_TIMEOUT) do
      yield
    end
  rescue Timeout::Error => exception
    raise exception, "No binlog events received within #{CLIENT_TIMEOUT} seconds"
  end
end
