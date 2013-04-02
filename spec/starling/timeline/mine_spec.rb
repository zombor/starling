require 'starling/timeline/mine'

describe Starling::Timeline::Mine do
  let(:client) { double(:client, :on_error => nil, :on_reconnect => nil, :on_max_reconnects => nil) }
  let(:output) { double(:output, :<< => nil) }
  let(:tweet) { double(:tweet, :id => 1234567890, :from_user => 'test', :text => 'text') }
  let(:starling_tweet) { double(:starling_tweet, :id => 1234567890) }
  let(:id_generator) { double(:id_generator) }

  subject { described_class.new(client, output, id_generator) }

  before :each do
    Starling::Tweet.stub(:new => starling_tweet)
  end

  it 'writes the userstream output to the output' do
    id_generator.should_receive(:store).with(tweet.id)

    client.stub(:userstream).and_yield(tweet)
    output.should_receive(:<<).with(starling_tweet)

    subject.latest
  end

  it 'calls the passed block' do
    id_generator.should_receive(:store).with(tweet.id)

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

  context :callbacks do
    it 'handles errors'
    it 'handles reconnects'
  end
end
