require 'spec_helper'

describe Mapper::Builder, '#mapper' do
  subject { object.mapper }

  let(:object) { described_class.new(mapper_class, model) }

  let(:mapper_class)      { mock('Mapper Class', :new => mapper) }
  let(:model)             { mock('Model')             }
  let(:attributes)        { mock('AttributeSet')      }

  let(:mapper)            { mock('Mapper')                       }

  before do
    object.stub(:attributes   => attributes)
  end

  it 'should initialize mapper with model and attributes' do
    mapper_class.should_receive(:new).with(model, attributes).and_return(mapper)
    should be(mapper)
  end
end
