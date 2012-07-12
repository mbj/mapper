require 'spec_helper'

describe Mapper::Attribute::EmbeddedDocument, '#dump' do
  let(:object) { described_class.new(:name, :mapper => mapper) }
  let(:mapper) { Mapper::Attribute::Object.new(:other_name)   }

  subject { object.dump(domain_object) }

  let(:domain_object) { mock(:name => value) }
  let(:coerced)       { mock }


  context 'when value is NOT nil' do
    let(:value) { mock }

    it 'should delegate each value to inner mapper' do
      mapper.should_receive(:dump).with(value).and_return(coerced)

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
