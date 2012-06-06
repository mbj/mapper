require 'spec_helper'

describe Mapper::AttributeSet,'#empty?' do
  let(:object) { described_class.new }

  subject { object.empty? }

  context 'when empty' do
    it { should be_true }
  end

  context 'when not empty' do
    before do
      object.add(Mapper::Attribute::Object.new(:foo))
    end

    it { should be_false }
  end
end
