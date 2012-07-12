require 'spec_helper'

describe Mapper, '.build' do
  subject { object.build(model, &block) }

  let(:object) { described_class }
  let(:model)  { mock            }
  let(:block)  { nil             }

  context 'without block' do
    it 'should raise error' do
      expect { subject }.to raise_error(ArgumentError, 'Need a block to build mapper')
    end
  end

  context 'with block defining attributes' do
    let(:block) do
      lambda do |mod|
        map :foo
      end
    end

    its(:model) { should equal(model) }

    it 'should have attributes' do
      subject.attributes.should_not be_empty
    end
  end
end
