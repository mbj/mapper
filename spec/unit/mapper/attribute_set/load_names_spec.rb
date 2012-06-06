require 'spec_helper'

describe Mapper::AttributeSet,'#load_names' do
  let(:object) { described_class.new }

  subject { object.load_names }

  context 'when empty' do
    it { should be_empty }
  end

  context 'when attribute is present' do
    before do
      object.add(Mapper::Attribute::Object.new(:name))
    end

    it 'should return attributes load names' do
      should == [:name]
    end
  end
end
