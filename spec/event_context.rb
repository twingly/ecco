java_import com.github.shyiko.mysql.binlog.event.EventType
java_import java.util.Arrays

shared_context "event" do
  let(:table_id) { 1 }
  let(:rows) do
    Java::JavaUtil::LinkedList.new(
      Arrays.asList(
        Array.new(1).to_java { Array.new(2).to_java }
      )
    )
  end
  let(:database) { "some_database" }
  let(:table) { "some_table" }
  let(:table_event_type) { EventType::TABLE_MAP }
  let(:row_event_type) { EventType::EXT_WRITE_ROWS }

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
