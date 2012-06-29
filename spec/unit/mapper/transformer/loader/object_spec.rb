require 'spec_helper'

describe Mapper::Transformer::Loader,'#object' do
  subject { object.object }

  let(:object)        { described_class.new(mapper,mock)                  }
  let(:mapper)        { mock('Mapper', :loaders => mock, :model => model) } 
  let(:model)         { mock('Model', :new => domain_object)              }
  let(:domain_object) { mock('Domain Object')                             }
  let(:attributes)    { mock('Attributes')                                }

  before do
    object.stub(:attributes => attributes)
  end

  it 'should instantiate model with attributes' do
    model.should_receive(:new).with(attributes)
    subject
  end

  it 'should return domain object' do
    should be(domain_object)
  end

  it_should_behave_like 'an idempotent method'
end
