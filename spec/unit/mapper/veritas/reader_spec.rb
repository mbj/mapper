require 'spec_helper'

describe Mapper::Veritas,'#reader' do

  subject { object.reader }

  let(:object) { described_class.new(model,attributes,relation) }

  let(:model)      { mock('Model')      }
  let(:attributes) { mock('Attributes') }
  let(:relation)   { mock('Relation')   }

  let(:reader)     { mock('Reader')     }

  before do
    Mapper::Veritas::Reader.stub(:new => reader) 
  end

  it { should be(reader) }
  
  it 'should create a new reader' do
    Mapper::Veritas::Reader.should_receive(:new).with(object,relation).and_return(reader)
    subject
  end
end
