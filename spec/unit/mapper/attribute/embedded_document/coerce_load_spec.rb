require 'spec_helper'

describe Mapper::Attribute::EmbeddedDocument,'#coerce_load' do
  let(:object) { described_class.new(:name,:mapper => mapper) }
  let(:mapper) { Mapper::Attribute::Object.new(:other_name)   }

  subject { object.coerce_load(value) }

  let(:coerced) { mock }
  let(:value)   { mock }

  context 'when value is NOT nil' do
    it 'should delegate each value to inner mapper' do
      mapper.should_receive(:load).with(value).and_return(coerced)
      subject.should be(coerced)
    end
  end

  context 'when value is nil' do
    let(:value) { nil }
    it 'should return nil' do
      should be_nil
    end
  end
end
