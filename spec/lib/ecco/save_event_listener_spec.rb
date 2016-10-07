describe Ecco::SaveEventListener do
  describe "#on_event" do
    include_context "client"

    let(:event_type) { EventType::ROTATE }

    let(:event) do
      event = double("event")

      allow(event).to receive_message_chain("get_header.get_event_type") do
        event_type
      end

      event
    end

    subject { described_class.new(client) }

    it "should return the binlog filename and position" do
      allow(subject).to receive(:accepted_events) { [event_type] }

      acutal_event_type_name = nil
      actual_filename, actual_position = [nil, 0]

      subject.callback = Proc.new do |filename, position, event_type_name|
        acutal_event_type_name = event_type_name
        actual_filename = filename
        actual_position = position
      end

      subject.on_event(event)

      expect(acutal_event_type_name).to eq("ROTATE")
      expect(actual_filename).to eq(binlog_filename)
      expect(actual_position).to eq(binlog_position)
    end
  end
end
