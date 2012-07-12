require 'spec_helper'

describe Mapper::Transformer, '#key' do
  subject { object.key }

  let(:object)        { described_class.new(mapper, domain_object) }

  let(:mapper)        { mock('Mapper')                    }
  let(:mapper)        { mock('Mapper')                    }
  let(:domain_object) { mock('Domain Object')             }
  let(:operations)    { mock('Operations', :keys => [:id]) }

  it_should_behave_like 'an idempotent method'

  before do
    object.stub(:operations => operations)
    object.stub(:id => :some_key)
  end

  it 'should return domain objects key' do
    should == { :id => :some_key }
  end
end
