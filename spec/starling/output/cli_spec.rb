require 'starling/output/cli'

describe Starling::Output::CLI do
  let(:tweet) { double(:tweet, :from_user => 'user', :text => 'text') }
  let(:data) {
    [
      tweet,
      tweet
    ]
  }

  it 'puts the array to $stdout' do
    begin
      $stdout = StringIO.new

      subject.output(data)
      $stdout.string.split("\n").size.should == 2
    ensure
      $stdout = STDOUT
    end
  end
end
