require 'spec_helper'

describe Mapper::ClassMethods,'#attribute_for_dump_name' do

  subject { object.attribute_for_dump_name(dump_name) }

  let(:dump_name) { :foo }

  context 'when attribute with dump name exist' do
    let(:object) do
      Mapper.new do
        map :foo,Object
      end
    end


    it 'should return that attribute' do
      should be_kind_of(Mapper::Attribute)
    end
  end

  context 'when attribute with dump name does NOT exist' do
    let(:object) do
      Mapper.new 
    end

    it 'should raise exception' do
      expect { subject }.to raise_error(ArgumentError)
    end
  end
end
