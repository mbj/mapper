require 'spec_helper'

describe Mapper::Transformer, '.mapper' do
  let(:object) do
    Class.new(described_class)
  end

  let(:mapper) { mock }

  subject { object.mapper }

  context 'when mapper setup was done' do
    before do
      object.instance_variable_set(:@mapper,mapper)
    end

    it 'should return mapper' do
      should be(mapper)
    end
  end

  context 'when mapper setup was NOT done' do
    it 'should raise error' do
      expect { subject }.to raise_error(RuntimeError,'mapper setup missing')
    end
  end
end

