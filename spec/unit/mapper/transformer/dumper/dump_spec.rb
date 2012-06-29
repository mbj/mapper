require 'spec_helper'

describe Mapper::Transformer::Dumper,'#dump' do
  let(:domain_object) { DomainObject.new }
  let(:mapper)        { DomainObjectMapper }

  let(:object)        { Mapper::Transformer::Dumper.new(mapper,domain_object) }

  subject { object.dump }

  it_should_behave_like 'an idempotent method'

  before do
    # These methods would have been defined by mapper through Attribute#define_dumper
    object.stub(:id =>  domain_object.id)
    object.stub(:foo => domain_object.foo)
  end

  it 'should return dumped object' do
    should == { :foo => :bar, :id => 1 }
  end
end
