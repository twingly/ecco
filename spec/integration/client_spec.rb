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
  let(:column_value) { "a value" }
  let(:mysql_row)    { { column1: column_value } }

  before do
    DatabaseHelper.create_table(table_name, columns: 1)
  end

  after do
    DatabaseHelper.drop_table(table_name)
  end

  context "when a row is inserted" do
    let(:row_event) do
      TestHelper.get_first_row_event_from_client(subject) do
        DatabaseHelper.insert(table_name, mysql_row)
      end
    end

    it "should receive a row event with correct type" do
      expect(row_event.type).to eq("WRITE_ROWS")
    end

    it "should receive a row event with the inserted row" do
      value_from_event = row_event.rows.first[1]

      expect(value_from_event).to eq(column_value)
    end
  end

  context "when a row is updated" do
    let(:update_value)   { "another value" }
    let(:update_columns) { { column1: update_value } }
    let(:row_event) do
      id = DatabaseHelper.insert(table_name, mysql_row)

      TestHelper.get_first_row_event_from_client(subject) do
        DatabaseHelper.update(table_name, id: id, columns: update_columns )
      end
    end

    it "should receive a row event with correct type" do
      expect(row_event.type).to eq("UPDATE_ROWS")
    end

    it "should receive a row event with the old and updated row" do
      value_before_update = row_event.rows.first.key[1]
      value_after_update  = row_event.rows.first.value[1]

      expect(value_before_update).to eq(column_value)
      expect(value_after_update).to eq(update_value)
    end
  end

  context "when a row is deleted" do
    let(:row_event) do
      id = DatabaseHelper.insert(table_name, mysql_row)

      TestHelper.get_first_row_event_from_client(subject) do
        DatabaseHelper.delete(table_name, id: id)
      end
    end

    it "should receive a row event with correct type" do
      expect(row_event.type).to eq("DELETE_ROWS")
    end

    it "should receive a row event with the deleted row" do
      value_from_event = row_event.rows.first[1]

      expect(value_from_event).to eq(column_value)
    end
  end
end
