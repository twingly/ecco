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

      actual_filename, actual_position = [nil, 0]
      acutal_event_type_name = nil

      subject.callback = Proc.new do |filename, position, event_type_name|
        actual_filename = filename
        actual_position = position
        acutal_event_type_name = event_type_name
      end

      subject.on_event(event)

      expect(actual_filename).to eq(binlog_filename)
      expect(actual_position).to eq(binlog_position)
      expect(acutal_event_type_name).to eq("ROTATE")
    end
  end
end
