require 'starling/access/token.rb'

describe Starling::Access::Token do
  it 'knows when it has a valid access token' do
    store = StringIO.new("{:token => 'foo', :secret => 'bar'}")
    token = Starling::Access::Token.new(store)
    token.has_token?.should be_true
  end

  it 'knows when it has an invalid access token' do
    store = StringIO.new
    token = Starling::Access::Token.new(store)
    token.has_token?.should be_false
  end

  it 'loads an access token when it exists' do
    store = StringIO.new("{:token => 'foo', :secret => 'bar'}")
    token = Starling::Access::Token.new(store).get_token
    token.should be_a(Hash)
    token[:token].should == 'foo'
    token[:secret].should == 'bar'
  end

  it 'does not bomb when loading an unexpected type from the datastore' do
    store = StringIO.new("'foobar'")
    Starling::Access::Token.new(store).get_token
  end

  it 'fails to load an access token when it does not exist' do
    store = StringIO.new
    token = Starling::Access::Token.new(store).get_token
    token.should be_nil
  end

  it 'saves a token to the datastore' do
    datastore = mock('store')
    datastore.should_receive(:puts).with(kind_of(Hash))
    token = Starling::Access::Token.new(datastore)
    token.save_token({:token => 'foo', :secret => 'bar'})
  end
end
