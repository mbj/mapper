require 'spec_helper'

describe Mapper::Transformer::Loader,'#attributes' do
  subject { object.attributes }

  let(:object)          { described_class.new(mapper,dump) }
  let(:dump)            { mock('Dump',:foo => value)       }
  let(:value)           { mock('Value')                    }

  let(:mapper) do 
    ::Mapper.build(DomainObject) do
      map :foo
    end
  end

  before do
    # This method would have been added by Attribute#define_loader
    object.stub(:foo => dump.foo)
  end

  it 'should call attribute reader method' do
    object.should_receive(:foo).and_return(value)
    subject
  end

  it 'should return attribute hash' do
    should == { :foo => value } 
  end

  it_should_behave_like 'an idempotent method'
end
