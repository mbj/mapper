require 'spec_helper'

describe Mapper::Builder,'.run' do
  subject { object.run(mapper_base_class,model,&block) }

  let(:object)            { described_class                    }
  let(:model)             { mock('Model')                      }
  let(:builder)           { mock('Builder', :mapper => mapper) }
  let(:mapper)            { mock('Mapper')                     }
  let(:mapper_base_class) { mock('Mapper Base Class') }

  context 'without block' do
    let(:block) { nil }

    it 'should raise error' do
      expect { subject }.to raise_error(ArgumentError,'Need a block to build mapper')
    end
  end

  context 'with block' do
    let(:block) { lambda { |instance| } }

    before do
      described_class.stub(:new => builder)
    end

    it 'should retun mapper' do
      should be(mapper)
    end

    it 'should instance eval block on builder' do
      executed = false
      builder.stub!(:instance_eval) do |proc|
        proc.should equal(block)
        executed = true
      end
      subject
      executed.should be_true
    end
  end
end
