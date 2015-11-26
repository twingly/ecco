require "spec_helper"

describe Ecco::Client do
  let(:client) do
    described_class.new(
      username: DatabaseHelper::USER,
      password: DatabaseHelper::PASS,
    )
  end

  describe "#get_server_id" do
    let(:server_id) { 1337 }

    before  { client.set_server_id(server_id) }
    subject { client.get_server_id }

    it { is_expected.to eq(server_id) }
  end

  describe "#is_keep_alive" do
    subject { client.is_keep_alive }

    context "when truthy" do
      before { client.set_keep_alive(true) }

      it { is_expected.to eq(true) }
    end

    context "when falsey" do
      before { client.set_keep_alive(false) }

      it { is_expected.to eq(false) }
    end
  end

  describe "#get_keep_alive_interval" do
    let(:keep_alive_interval) { 30 }

    before  { client.set_keep_alive_interval(keep_alive_interval) }
    subject { client.get_keep_alive_interval }

    it { is_expected.to eq(keep_alive_interval) }
  end

  describe "#set_keep_alive_connect_timeout" do
    let(:keep_alive_connect_timeout) { 300 }

    before  { client.set_keep_alive_connect_timeout(keep_alive_connect_timeout) }
    subject { client.get_keep_alive_connect_timeout }

    it { is_expected.to eq(keep_alive_connect_timeout) }
  end

  describe "#get_binlog_filename" do
    let(:binlog_filename) { "foo" }

    before  { client.set_binlog_filename(binlog_filename) }
    subject { client.get_binlog_filename }

    it { is_expected.to eq(binlog_filename) }
  end

  describe "#get_binlog_position" do
    let(:binlog_position) { 99 }

    before  { client.set_binlog_position(binlog_position) }
    subject { client.get_binlog_position }

    it { is_expected.to eq(binlog_position) }
  end
end
