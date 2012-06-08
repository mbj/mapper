require 'spec_helper'

describe Mapper::ClassMethods,'#dump' do
  let(:domain_object) do 
    DomainObject.new(:foo => :bar)
  end

  let(:described_class) do
    ::Mapper.new do
      map :foo, Object
    end
  end

  let(:object) { described_class }

  subject { object.dump(domain_object) }

  it 'should return dumped object' do
    should == { :foo => :bar }
  end
end
