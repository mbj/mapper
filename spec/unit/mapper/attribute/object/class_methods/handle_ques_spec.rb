require 'spec_helper'

describe Mapper::Attribute::Object,'.handle?' do
  let(:object) { described_class }

  subject { object.handle?(class_or_name) }

  context 'with ::Object' do
    let(:class_or_name) { ::Object }
    it { should be_true }
  end

  context 'with :Object' do
    let(:class_or_name) { :Object }
    it { should be_true }
  end

  context 'with Mapper::Attribute::Object' do
    let(:class_or_name) { Mapper::Attribute::Object }
    it { should be_true }
  end

  context 'with anything elase' do
    it 'should be false' do
      [Mapper,Object.new,Mapper::Attribute::EmbeddedDocument].each do |input|
        object.handle?(input).should be_false
      end
    end
  end
end
