class TestHelper
  def self.get_row_events_from_client(ecco_client, count: 1)
    received_row_events = []

    ecco_client.on_row_event do |row_event|
      received_row_events << row_event
      ecco_client.stop if received_row_events.count == count
    end

    thread = start_client_in_thread(ecco_client)

    yield

    thread.join

    # So you don't have to run .first in the tests
    return received_row_events.first if count == 1

    received_row_events
  end

  def self.get_save_position_events_from_client(ecco_client, count: 1)
    received_save_position_events = []

    ecco_client.on_save_position do |filename, position|
      received_save_position_events << {
        filename: filename,
        position: position,
      }
      ecco_client.stop if received_save_position_events.count == count
    end

    thread = start_client_in_thread(ecco_client)

    yield if block_given?

    thread.join

    # So you don't have to run .first in the tests
    return received_save_position_events.first if count == 1

    received_save_position_events
  end

  def self.start_client_in_thread(ecco_client)
    thread = Thread.new do |t|
      ecco_client.start
    end

    sleep 1

    thread
  end

  private_class_method :start_client_in_thread
end
