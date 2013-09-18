require 'starling/command'

describe Starling::Command do
  let(:client) { double(:twitter_client) }
  let(:timeline) { double(:timeline) }
  let(:output) { double(:output) }
  let(:storage) { double(:storage) }

  subject { described_class.new(client, timeline, output, storage) }

  it 'outputs an error message if the command does not exist' do
    output.should_receive(:output).with(["\e[0;31;49mNo such command: foobar\e[0m"])

    subject.process('/foobar')
  end

  it 'delegates to command methods if the command exists' do
    subject.should_receive(:quit)

    subject.process('/quit')
  end

  it 'sends a tweet if no command character is found' do
    client.should_receive(:send_tweet).with('test')

    subject.process('test')
  end

  it 'quits' do
    timeline.should_receive(:stop)

    subject.process('/quit')
  end

  it 'replies' do
    id = 1234567890
    token = 'aa'

    storage.should_receive(:fetch).with('aa').and_return(id)
    client.should_receive(:reply).with(id, '@rspec test')
    client.should_receive(:find_by_id).with(id).and_return(double(:tweet, :from_user => 'rspec'))

    subject.process("/reply $#{token} test")
  end

  context :again do
    let(:tweet1) { double(:tweet1) }
    let(:tweet2) { double(:tweet2) }
    let(:processed_tweet1) { double(:processed_tweet1) }
    let(:processed_tweet2) { double(:processed_tweet2) }

    before :each do
      tweet1.stub(:id).and_return(1)
      tweet2.stub(:id).and_return(2)
      Starling::Tweet.stub(:new).and_return(processed_tweet2, processed_tweet1)
      storage.should_receive(:store).twice
      output.should_receive(:output).with([processed_tweet2, processed_tweet1])
    end

    it 'fetches a list of recent tweets with a default count' do
      client.should_receive(:home_timeline).and_return([tweet1, tweet2])

      subject.process '/again'
    end

    it 'fetches a specific list of recent tweets' do
      client.should_receive(:home_timeline).with(5).and_return([tweet1, tweet2])

      subject.process '/again 5'
    end
  end
end
