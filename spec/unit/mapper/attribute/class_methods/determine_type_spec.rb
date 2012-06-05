require 'spec_helper'

describe Mapper::Attribute, '.determine_type' do
  let(:object) { described_class }

  subject { object.determine_type(class_or_name) }

  context 'with ::Object' do
    let(:class_or_name) { ::Object }

    it { should be(Mapper::Attribute::Object) }
  end

  context 'with undeterminable type' do 
    let(:class_or_name) { Object.new }

    it 'should raise error' do
      expect { subject }.to raise_error(ArgumentError,"unable to determine type from: #{class_or_name.inspect}")
    end
  end

  context 'with :EmbeddedCollection' do
    let(:class_or_name) { :EmbeddedCollection }

    it { should be(Mapper::Attribute::EmbeddedCollection) }
  end
end
