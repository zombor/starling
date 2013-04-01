require 'starling/id_generate'

describe Starling::IdGenerate do
  let(:storage) { {} }
  let(:id) { 1234567890 }

  subject { described_class.new(storage) }

  it 'stores an id and returns a token' do
    token = subject.store(id)

    storage[token].should == id
  end

  it 'retrives an id for a token' do
    storage['aa'] = id

    subject.fetch('aa').should == id
  end
end
