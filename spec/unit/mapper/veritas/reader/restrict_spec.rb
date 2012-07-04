require 'spec_helper'

# This spec makes shure the unless kind_of?(Veritas::Relation) branch in #forward is taken
describe Mapper::Veritas::Reader,'#restrict' do
  subject { object.restrict { |r| r.id.eq(1) } }

  let!(:object) { described_class.new(mapper,relation) }

  let(:mapper)   { mock('Mapper')                                              }
  let(:relation) { mock('Relation', :respond_to? => true, :restrict => result) }
  let(:result)   { mock('Result', :kind_of? => true)                           }
  let(:data)     { [[1],[2]]                                                   }

  before do
    relation.stub(:description => :foo)
  end

  it 'should forward the message to relation' do
    relation.should_receive(:restrict)

    subject
  end

  it 'should instantiate a new reader' do
    described_class.should_receive(:new).with(mapper,result)

    subject
  end
end
