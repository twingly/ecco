class TestHelper
  def self.get_first_row_event_from_client(ecco_client)
    received_row_event = nil

    ecco_client.on_row_event do |row_event|
      received_row_event = row_event
      ecco_client.stop
    end

    thread = Thread.new do |t|
      ecco_client.start
    end

    sleep 1
    yield

    thread.join

    received_row_event
  end
end
