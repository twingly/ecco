describe Ecco::RowsConverter do
  include_context "event"

  describe "#convert" do
    context "UPDATE_ROWS" do
      let(:converted_update_rows) do
          Ecco::RowsConverter.convert(rows_for_update_event, "UPDATE_ROWS")
      end

      it "are deep converted to Ruby objects" do
        expect(converted_update_rows).to be_an_instance_of(Array)
        expect(converted_update_rows).to all(be_an_instance_of(Ecco::UpdateRowsEventUpdatedRow))

        converted_update_rows.each do |row|
          expect(row.before).to be_an_instance_of(Array)
          expect(row.after).to be_an_instance_of(Array)
        end
      end
    end

    context "WRITE_ROWS" do
      let(:converted_write_rows) do
        Ecco::RowsConverter.convert(rows_for_write_and_delete_events, "WRITE_ROWS")
      end

      it "are deep converted to Ruby objects" do
        expect(converted_write_rows).to be_an_instance_of(Array)
      end
    end

    context "DELTE_ROWS" do
      let(:converted_delete_rows) do
        Ecco::RowsConverter.convert(rows_for_write_and_delete_events, "DELETE_ROWS")
      end

      it "are deep converted to Ruby objects" do
        expect(converted_delete_rows).to be_an_instance_of(Array)
      end
    end
  end
end
