require 'spec_helper'

describe Mapper::AttributeSet,'#empty?' do
  let(:object) { described_class.new }

  subject { object.empty? }

  context 'when empty' do
    it { should be_true }
    it_should_behave_like 'an idempotent method'
  end

  context 'when not empty' do
    before do
      object.add(Mapper::Attribute::Object.new(:foo))
    end

    it_should_behave_like 'an idempotent method'
    it { should be_false }
  end
end
