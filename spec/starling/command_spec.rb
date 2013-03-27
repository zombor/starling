require 'starling/command'

describe Starling::Command do
  let(:client) { double(:twitter_client) }
  let(:timeline) { double(:timeline) }
  let(:output) { double(:output) }

  subject { described_class.new(client, timeline, output) }

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
end
