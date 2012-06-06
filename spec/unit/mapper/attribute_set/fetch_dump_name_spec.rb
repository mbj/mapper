require 'spec_helper'

describe Mapper::AttributeSet,'#fetch_dump_name' do
  let(:object) { described_class.new }

  subject { object.fetch_dump_name(dump_name) }

  let(:attribute) do
    Mapper::Attribute::Object.new(:load_name,:to => :dump_name)
  end

  before do
    object.add(attribute)
  end

  context 'when dump name exists' do
    let(:dump_name) { :dump_name }

    it 'should return attribute' do
      should be(attribute)
    end
  end
  
  context 'when dump name does NOT exist' do
    let(:dump_name) { :unexistend }

    it 'should raise ArgumentError' do
      expect { subject }.to raise_error(ArgumentError,"no attribute with dump name of :unexistend does exist")
    end
  end
end
