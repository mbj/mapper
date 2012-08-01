require 'spec_helper'

describe Mapper::Attribute::Object, '#load' do
  let(:object)  { described_class.new(name, options) }

  let(:name)    { :name }
  let(:options) { {} }

  let(:value)   { mock }
  let(:dump)    { mock(:name => value) }

  subject { object.load(dump) }

  context 'with defaults' do
    it 'should load value' do
      should be(value)
    end
  end

  context 'with aliased dump name' do
    let(:options) { { :to => :other } }
    let(:dump)    { mock(:other => value) }
    it 'should load value' do
      should be(value)
    end
  end
end
