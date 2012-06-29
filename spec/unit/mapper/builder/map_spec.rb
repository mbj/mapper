require 'spec_helper'

describe Mapper::Builder,'#map' do
  subject { object.map(name,attribute_class,options) }

  let(:object) { described_class.new(mapper_base_class,model) }

  let(:model)             { mock('Model')             }
  let(:mapper_base_class) { mock('Mapper Base Class') }
  let(:options)           { mock('Options')           }

  let(:name)              { mock('Name')              }
  let(:attribute_class)   { mock('Attriute Class')    }

  let(:attribute)         { mock('Attribute')         }

  before do
    Mapper::Attribute.stub(:build => attribute)
  end

  it 'should add attribute to attribnute_set' do
    subject
    object.send(:attributes).should include(attribute)
  end

  it 'should create attribute' do
    Mapper::Attribute.should_receive(:build).with(name,attribute_class,options).and_return(attribute)
    subject
  end

  context 'without options argument' do
    let(:options) { {} }

    subject { object.map(name,attribute_class) }

    it 'should create attribute with default options' do
      Mapper::Attribute.should_receive(:build).with(name,attribute_class,options).and_return(attribute)
      subject
    end
  end
end
