require 'spec_helper'

describe Mapper::Veritas::Builder, '#mapper' do

  subject { object.mapper }

  let(:object) { described_class.new(mapper_class, model) }

  let(:mapper_class) { mock('Mapper Class', :new => mapper) }
  let(:model)        { mock('Model')                        }
  let(:relation)     { mock('Relation')                     }
  let(:mapper)       { mock('Mapper')                       }

  context 'when builder has a relation set' do
    before do
      object.relation(relation)
    end

    it { should be(mapper) }

    it 'should instanctiate mapper' do 
      mapper_class.should_receive(:new).with(model, object.send(:attributes), relation)
      subject
    end
  end

  context 'when builder has no relation' do
    it 'should raise error' do
      expect { subject }.to raise_error(Mapper::Builder::IncompleteMapperError, 'no relation is set')
    end
  end
end
