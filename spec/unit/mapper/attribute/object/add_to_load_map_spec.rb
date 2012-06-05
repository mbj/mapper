require 'spec_helper'

describe Mapper::Attribute::Object,'#add_to_load_map' do
  let(:object)   { described_class.new(:name,options) }
  let(:options)  { {}                                 }
  let(:load_map) { {}                                 }

  subject { object.add_to_load_map(load_map) }

  context 'with default options' do
    it 'should add load_name to load map' do
      subject
      load_map.should == { :name => object }
    end

    it 'should return self' do
      should be(object)
    end
  end
end
