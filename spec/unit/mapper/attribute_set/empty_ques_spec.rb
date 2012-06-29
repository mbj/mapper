require 'spec_helper'

describe Mapper::AttributeSet,'#empty?' do
  subject { object.empty? }

  let(:object) { described_class.new }

  context 'when empty' do
    it { should be(true) }

    it_should_behave_like 'an idempotent method'
  end

  context 'when not empty' do
    before do
      object.add(Mapper::Attribute::Object.new(:foo))
    end

    it_should_behave_like 'an idempotent method'

    it { should be(false) }
  end
end
