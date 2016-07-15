describe Ecco::RowEventListener do
  describe "#on_event" do
    include_context "client"
    include_context "event"

    subject { described_class.new(client) }

    it "should return a row event with correct values" do
      allow(subject).to receive(:accepted_events) { [row_event_type] }
      allow(subject).to receive(:table_event) { table_event_type }

      actual_type     = nil
      actual_table_id = 0
      actual_rows     = nil
      actual_database = nil
      actual_table    = nil

      subject.callback = Proc.new do |row_event|
        actual_type     = row_event.type
        actual_table_id = row_event.table_id
        actual_database = row_event.database
        actual_table    = row_event.table
        actual_rows     = row_event.rows
      end

      subject.on_event(table_event)
      subject.on_event(row_event)

      expect(actual_type).to eq("WRITE_ROWS")
      expect(actual_table_id).to eq(table_id)
      expect(actual_rows).to eq(rows)
      expect(actual_database).to eq(database)
      expect(actual_table).to eq(table)
    end
  end
end
