require 'spec_helper'

describe Mapper::Attribute::Object,'#add_to_dump_map' do
  let(:object)   { described_class.new(:name,options) }
  let(:options)  { {}                                 }
  let(:dump_map) { {}                                 }

  subject { object.add_to_dump_map(dump_map) }

  context 'with default options' do
    it 'should add dump_name to dump map' do
      subject
      dump_map.should == { :name => object }
    end

    it 'should return self' do
      should be(object)
    end
  end

  context 'with aliasing dump' do
    let(:options) { { :to => :other } }

    it 'should add dump_name to dump map' do
      subject
      dump_map.should == { :other => object }
    end

    it 'should return self' do
      should be(object)
    end
  end
end
