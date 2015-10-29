shared_context "event" do
  let(:table_id) { 1 }
  let(:rows) { double("List") }
  let(:database) { "some_database" }
  let(:table) { "some_table" }
  let(:table_event_type) { "event_type_table_map" }
  let(:row_event_type) { "event_type_write_rows" }

  let(:table_event) do
    event = double("Event")

    allow(event).to receive_message_chain("get_header.get_event_type") do
      table_event_type
    end

    data = double("TableMapEventData",
      get_database: database,
      get_table: table
    )

    allow(event).to receive(:get_data) do
      data
    end

    event
  end

  let(:row_event) do
    event = double("Event")

    allow(event).to receive_message_chain("get_header.get_event_type") do
      row_event_type
    end

    data = double("WriteRowsEventData",
      get_table_id: table_id,
      rows: rows
    )

    allow(event).to receive(:get_data) do
      data
    end

    event
  end
end
