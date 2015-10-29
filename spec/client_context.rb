shared_context "client" do
  let(:binlog_filename) { "mysql-bin.000001" }
  let(:binlog_position) { 107 }

  let(:client) do
    client = instance_double("Ecco::Client")
    allow(client).to receive(:get_binlog_filename) { binlog_filename }
    allow(client).to receive(:get_binlog_position) { binlog_position }
    client
  end
end
