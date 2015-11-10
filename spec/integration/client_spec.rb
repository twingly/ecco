require "spec_helper"
require "timeout"

describe Ecco::Client do
  subject do
    described_class.new(
      username: DatabaseHelper::USER,
      password: DatabaseHelper::PASS,
    )
  end

  let(:table_name)   { :ecco_test_table }
  let(:mysql_row)    { { column1: "a value" } }

  before do
    DatabaseHelper.create_table(table_name, columns: 1)
  end

  after do
    DatabaseHelper.drop_table(table_name)
  end

  context "when a row is inserted" do
    it "should receive a row event with correct type" do
      row_event = TestHelper.get_first_row_event_from_client(subject) do
        DatabaseHelper.insert(table_name, mysql_row)
      end

      expect(row_event.type).to eq("WRITE_ROWS")
    end
  end

  context "when a row is updated" do
    let(:columns) { { column1: "another value" } }

    it "should receive a row event with correct type" do
      id = DatabaseHelper.insert(table_name, mysql_row)

      row_event = TestHelper.get_first_row_event_from_client(subject) do
        DatabaseHelper.update(table_name, id: id, columns: columns )
      end

      expect(row_event.type).to eq("UPDATE_ROWS")
    end
  end

  context "when a row is deleted" do
    it "should receive a row event with correct type" do
      id = DatabaseHelper.insert(table_name, mysql_row)

      row_event = TestHelper.get_first_row_event_from_client(subject) do
        DatabaseHelper.delete(table_name, id: id)
      end

      expect(row_event.type).to eq("DELETE_ROWS")
    end
  end
end
