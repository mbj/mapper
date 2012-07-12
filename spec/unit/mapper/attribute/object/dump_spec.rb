require 'spec_helper'

describe Mapper::Attribute::Object, '#dump' do
  let(:object)  { described_class.new(name, options) }
    
  let(:name)    { :name }
  let(:options) { {} }

  let(:value)   { mock }
  let(:domain_object)  { mock(:name => value) }

  subject { object.dump(domain_object) }

  context 'with defaults' do
    it 'should load value' do
      should be(value)
    end

    it_should_behave_like 'an idempotent method'
  end

  context 'with aliased dump name' do
    let(:options) { { :to => :other } }

    it 'should load value' do
      should be(value)
    end

    it_should_behave_like 'an idempotent method'
  end
end
