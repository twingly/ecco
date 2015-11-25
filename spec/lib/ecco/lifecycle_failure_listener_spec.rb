java_import java.io.IOException
java_import com.github.shyiko.mysql.binlog.BinaryLogClient

describe Ecco::LifecycleFailureListener do
  describe "#onCommunicationFailure" do
    let(:client) { BinaryLogClient.new("localhost", 3306, "user", "password") }
    let(:error_message) { "Boom!" }
    let(:exception) { IOException.new(error_message) }

    it "should return the client and an error" do
      actual_client = nil
      actual_error = nil

      subject.callback = Proc.new do |client, error|
        actual_client = client
        actual_error = error
      end

      subject.onCommunicationFailure(client, exception)

      expect(actual_client).to eq(client)
      expect(actual_error).to be_a(Ecco::Error::CommunicationError)
      expect(actual_error.message).to eq(error_message)
    end
  end
end
