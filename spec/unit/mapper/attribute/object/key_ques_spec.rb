require 'spec_helper'

describe Mapper::Attribute::Object,'#key?' do
  let(:object) { described_class.new(:name, options) }

  subject { object.key? }

  context 'when options are empty' do
    let(:options) { {} }
    it { should be_false }
  end

  context 'when option :key contains false' do
    let(:options) { {:key => false } }
    it { should be_false }
  end

  context 'when option :key contains a falsy value' do
    let(:options) { {:key => nil } }
    it { should be_false }
  end

  context 'when option :key contains a truly value' do
    let(:options) { {:key => "foo" } }
    it { should be_true }
  end

  context 'when option :key contains true' do
    let(:options) { {:key => true } }
    it { should be_true }
  end
end
