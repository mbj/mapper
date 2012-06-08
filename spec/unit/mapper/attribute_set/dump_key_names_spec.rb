require 'spec_helper'

describe Mapper::AttributeSet,'#dump_key_names' do
  let(:object)          { described_class.new }
  let(:key_attribute)   { Mapper::Attribute::Object.new(:key,:key => true) }
  let(:other_attribute) { Mapper::Attribute::Object.new(:foo) }

  subject { object.dump_key_names }

  context 'when set is empty' do
    it { should be_empty }
  end

  context 'when set only contains non key attributes' do
    before do
      object.add(other_attribute)
    end

    it { should be_empty }
  end

  context 'when set contains key attribute' do
    before do
      object.add(other_attribute)
      object.add(key_attribute)
    end

    it 'return key attribute dump name' do 
      should == [:key] 
    end
  end

  context 'when we accessed dump_key names before adding new attribute' do
    before do
      object.add(other_attribute)
      object.dump_key_names
      object.add(key_attribute)
    end

    it 'return key attribute dump name' do 
      should == [:key] 
    end
  end
end
