require 'spec_helper'

describe Mapper::Transformer, '#read' do

  subject { object.send(:read, name) }

  let(:object)   { described_class.new(mapper, source) }
  let(:mapper)   { mock('Mapper')   }
  let(:source)   { mock('Source')   }
  let(:name)     { mock('Name')     }
  let(:response) { mock('Response') }

  let(:operations) { mock('Operations') }

  before do
    object.stub(:operations => operations)
    operations.stub(:execute => response)
  end

  it_should_behave_like 'an idempotent method' 

  it 'should return response' do
    should be(response)
  end

  it 'should memonize results' do
    operations.should_receive(:execute).with(name, source).once.and_return(response)
    object.send(:read, name)
    object.send(:read, name)
  end

  it 'should call execute on operations with name and source' do
    operations.should_receive(:execute).with(name, source).and_return(response)
    subject
  end
end
