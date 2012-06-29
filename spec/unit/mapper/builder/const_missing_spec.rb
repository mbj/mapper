require 'spec_helper'

describe Mapper::Builder,'#const_missing' do
  let(:object) { described_class.new(mapper_class,model) }

  let(:mapper_class) { mock('Mapper Class') }
  let(:model)        { mock('Model') }

  subject { object.send(:const_missing,value) }

  context 'when :Object is passed' do
    let(:value) { :Object }
    it { should be(Mapper::Attribute::Object) }
    it_should_behave_like 'an idempotent method'
  end

  context 'when :EmbeddedCollection is passed' do
    let(:value) { :EmbeddedCollection }
    it { should be(Mapper::Attribute::EmbeddedCollection) }
    it_should_behave_like 'an idempotent method'
  end

  context 'when :EmbeddedDocument is passed' do
    let(:value) { :EmbeddedDocument }
    it { should be(Mapper::Attribute::EmbeddedDocument) }
    it_should_behave_like 'an idempotent method'
  end

  context 'when :UnkownMapping is passed' do
    let(:value) { :UnkownMapping }
    it 'should raise error' do
      expect { subject }.to raise_error(ArgumentError,'Unable to determine mapping from: :UnkownMapping')
    end
  end
end
