require 'spec_helper'

describe Mapper::AttributeSet,'#fetch_load_name' do
  let(:object) { described_class.new }

  subject { object.fetch_load_name(load_name) }

  let(:attribute) do
    Mapper::Attribute::Object.new(:load_name,:to => :load_name)
  end

  before do
    object.add(attribute)
  end

  context 'when load name exists' do
    let(:load_name) { :load_name }

    it 'should return attribute' do
      should be(attribute)
    end

    it_should_behave_like 'an idempotent method'
  end
  
  context 'when load name does NOT exist' do
    let(:load_name) { :unexistend }

    it 'should raise ArgumentError' do
      expect { subject }.to raise_error(IndexError)
    end
  end
end
