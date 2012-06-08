require 'spec_helper'

describe Mapper::Transformer::Dumper,'#dump' do
  let(:domain_object) do 
    mock(:foo => :bar)
  end

  let(:mapper) do 
    ::Mapper.new do
      map :foo, Object
    end
  end

  let(:described_class) { mapper::Dumper                     }
  let(:object)          { described_class.new(domain_object) }

  subject { object.dump }

  before do
    object.stub(:mapper => mapper)
  end

  it 'should return dumped object' do
    should == { :foo => :bar }
  end
end
