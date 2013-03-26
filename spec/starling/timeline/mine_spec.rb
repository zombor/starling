require 'starling/timeline/mine'

describe Starling::Timeline::Mine do
  let(:client) { double(:client) }
  let(:output) { double(:output, :<< => nil) }
  let(:tweet) { double(:tweet, :from_user => 'test', :text => 'text') }

  subject { described_class.new(client, output) }

  it 'writes the userstream output to the output' do
    client.stub(:userstream).and_yield(tweet)
    output.should_receive(:<<).with(tweet)

    subject.latest
  end

  it 'calls the passed block' do
    client.stub(:userstream).and_yield(tweet)
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
