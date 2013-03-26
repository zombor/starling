require 'starling/timeline/mine'

describe Starling::Timeline::Mine do
  let(:client) { double(:client) }
  let(:output) { double(:output, :write => nil) }

  subject { described_class.new(client, output) }

  it 'writes the userstream output to the output' do
    client.stub(:userstream).and_yield(:foo)
    output.should_receive(:write).with(:foo.inspect)

    subject.latest
  end

  it 'calls the passed block' do
    client.stub(:userstream).and_yield(:foo)
    called = false
    block = Proc.new { called = true }

    subject.latest(&block)
    called.should be_true
  end

  it 'stops the stream' do
    client.should_receive(:stop)

    subject.stop
  end
end
