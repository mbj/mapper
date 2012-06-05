require 'spec_helper'

describe Mapper::Attribute::Custom,'#add_to_dump_map' do
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

  context 'when dumping to many fields' do 
    let(:options) { { :to => [:a,:b] } }
    it 'should add all fields to dump map' do
      subject
      dump_map.should == { :a => object, :b => object }
    end

    it 'should return self' do
      should be(object)
    end
  end
end
