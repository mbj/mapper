require 'spec_helper'

describe Mapper::Transformer::Dumper,'#key' do
  let(:mapper) do
    Mapper.new do
      map :id, Object, :key => true
      map :foo, Object
    end
  end

  let(:domain_object) do
    DomainObject.new(:id => :some_key,:foo => :bar)
  end

  let(:described_class) { mapper::Dumper                     }
  let(:object)          { described_class.new(domain_object) }

  subject { object.key }

  it_should_behave_like 'an idempotent method'

  it 'should return domain objects key' do
    should == { :id => :some_key }
  end 
end
