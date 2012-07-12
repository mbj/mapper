require 'spec_helper'

describe Mapper::Attribute::Custom, '#dump_names' do
  let(:object)  { described_class.new(name, options) }
  let(:name)    { :name }
  let(:options) { {} }

  subject { object.dump_names }

  context 'with defaults' do
    it 'should return name' do
      should == [:name]
    end
  end

  context 'with multiple names in :to option' do
    let(:options) { { :to => [:foo, :bar] } }

    it 'should return dump_names' do
      should == [:foo, :bar]
    end
  end
end
