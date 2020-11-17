java_import java.util.ArrayList
java_import java.util.AbstractMap

describe Ecco::RowEventListener do
  describe "#on_event" do
    include_context "client"
    include_context "event"

    subject { described_class.new(client) }

    before do
      allow(subject).to receive(:accepted_events) { [row_event_type] }
      allow(subject).to receive(:table_event) { table_event_type }
    end

    it "should return a row event with correct values" do
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

      expect(actual_type).not_to be_empty
      expect(actual_table_id).to eq(table_id)
      expect(actual_rows).to eq(rows)
      expect(actual_database).to eq(database)
      expect(actual_table).to eq(table)
    end

    describe "RowEvent#type" do
      context "MySQL v1 ROW_EVENTS" do
        context "WRITE_ROWS" do
          let(:row_event_type) { EventType::WRITE_ROWS }
          it "should return WRITE_ROWS" do
            actual_type = nil
            subject.callback = Proc.new do |row_event|
              actual_type = row_event.type
            end

            subject.on_event(row_event)

            expect(actual_type).to eq("WRITE_ROWS")
          end
        end

        context "UPDATE_ROWS" do
          let(:row_event_type) { EventType::UPDATE_ROWS }
          it "should return UPDATE_ROWS" do
            actual_type = nil
            subject.callback = Proc.new do |row_event|
              actual_type = row_event.type
            end

            subject.on_event(row_event)

            expect(actual_type).to eq("UPDATE_ROWS")
          end
        end

        context "DELETE_ROWS" do
          let(:row_event_type) { EventType::DELETE_ROWS }
          it "should return DELETE_ROWS" do
            actual_type = nil
            subject.callback = Proc.new do |row_event|
              actual_type = row_event.type
            end

            subject.on_event(row_event)

            expect(actual_type).to eq("DELETE_ROWS")
          end
        end
      end

      context "MySQL v2 ROW_EVENTS" do
        context "EXT_WRITE_ROWS" do
          let(:row_event_type) { EventType::EXT_WRITE_ROWS }
          it "should return WRITE_ROWS" do
            actual_type = nil
            subject.callback = Proc.new do |row_event|
              actual_type = row_event.type
            end

            subject.on_event(row_event)

            expect(actual_type).to eq("WRITE_ROWS")
          end
        end

        context "EXT_UPDATE_ROWS" do
          let(:row_event_type) { EventType::EXT_UPDATE_ROWS }
          it "should return UPDATE_ROWS" do
            actual_type = nil
            subject.callback = Proc.new do |row_event|
              actual_type = row_event.type
            end

            subject.on_event(row_event)

            expect(actual_type).to eq("UPDATE_ROWS")
          end
        end

        context "EXT_DELETE_ROWS" do
          let(:row_event_type) { EventType::EXT_DELETE_ROWS }
          it "should return DELETE_ROWS" do
            actual_type = nil
            subject.callback = Proc.new do |row_event|
              actual_type = row_event.type
            end

            subject.on_event(row_event)

            expect(actual_type).to eq("DELETE_ROWS")
          end
        end
      end
    end
  end
end
