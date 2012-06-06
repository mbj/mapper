require 'spec_helper'

describe Mapper::ClassMethods,'#const_missing' do
  let(:object) { Mapper.new }

  subject { object.send(:const_missing,value) }

  context 'when :Object is passed' do
    let(:value) { :Object }
    it { should be(Mapper::Attribute::Object) }
  end

  context 'when :EmbeddedCollection is passed' do
    let(:value) { :EmbeddedCollection }
    it { should be(Mapper::Attribute::EmbeddedCollection) }
  end

  context 'when :EmbeddedDocument is passed' do
    let(:value) { :EmbeddedDocument }
    it { should be(Mapper::Attribute::EmbeddedDocument) }
  end

  context 'when :UnkownMapping is passed' do
    let(:value) { :UnkownMapping }
    it 'should raise error' do
      expect { subject }.to raise_error(ArgumentError,'Unable to determine mapping from: :UnkownMapping')
    end
  end
end
