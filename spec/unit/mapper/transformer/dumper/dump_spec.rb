require 'spec_helper'

describe Mapper::Transformer::Dumper, '#dump' do
  let(:domain_object) { DomainObject.new }

  let(:mapper)     { mock('Mapper', :attributes => attributes)          }
  let(:attributes) { mock('Attributes', :dump_operations => operations) }
  let(:operations) { mock('Operations', :names => [:id, :foo])           }

  let(:object)     { Mapper::Transformer::Dumper.new(mapper, domain_object) }

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

  it 'should call reader methods' do
    object.should_receive(:id)
    object.should_receive(:foo)
    subject
  end
end
