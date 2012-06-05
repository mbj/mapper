require 'spec_helper'

describe Mapper::AttributeSet,'#fetch_dump_name' do
  let(:object) { described_class.new }

  subject { object.fetch_dump_name(dump_name) }

  let(:attribute) do
    Object.new.extend(Module.new do
      def add_to_load_map(load_map)
        load_map[:load_name]=self
      end

      def add_to_dump_map(dump_map)
        dump_map[:dump_name]=self
      end
    end)
  end

  before do
    object.add(attribute)
  end

  context 'when dump name exists' do
    let(:dump_name) { :dump_name }

    it 'should return attribute' do
      should be(attribute)
    end
  end
  
  context 'when dump name does NOT exist' do
    let(:dump_name) { :unexistend }

    it 'should raise ArgumentError' do
      expect { subject }.to raise_error(ArgumentError,"no attribute with dump name of :unexistend does exist")
    end
  end
end
