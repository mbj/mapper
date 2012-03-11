require 'spec_helper'

describe Mapper::Mapper::Attribute,'#key?' do
  let(:object) do
    described_class.new(:some_name,options)
  end

  let(:options) { {} }

  subject { object.key? }

  context 'without options' do
    it { should be_false }
  end

  context 'with :key set to false' do
    let(:options) { { :key => false } }
    it { should be_false }
  end

  context 'with :key set to nil' do
    let(:options) { { :key => false } }
    it { should be_false }
  end

  context 'with :key set to true' do
    let(:options) { { :key => true } }
    it { should be_true }
  end

  context 'with :key set to ""' do
    let(:options) { { :key => true } }
    it { should be_true }
  end
end
