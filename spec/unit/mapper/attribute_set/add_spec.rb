require 'spec_helper'

describe Mapper::AttributeSet,'#add' do
  subject { object.add(attribute) }

  let(:object)    { described_class.new                                         }
  let(:attribute) { Mapper::Attribute::Object.new(:load_name,:to => :dump_name) }

  let(:load_names) { object.load_operations.names }
  let(:dump_names) { object.dump_operations.names }

  context 'when attribute set is empty' do
    it_should_behave_like 'a command method'

    it 'should add attribute to load names' do
      subject
      load_names.should == [:load_name].to_set
    end

    it 'should add attribute to dump names' do
      subject
      dump_names.should == [:dump_name].to_set
    end
  end

  context 'when attribute set is not empty' do
    before do
      object.add(Mapper::Attribute::Object.new(:something))
      # make sure we have a memonized operations in attribute set
      object.load_operations.names
      object.dump_operations.names
    end

    it_should_behave_like 'a command method'

    it 'should still add attribute to load names' do
      subject
      load_names.should == [:something,:load_name].to_set
    end

    it 'should still add attribute to dump names' do
      subject
      dump_names.should == [:something,:dump_name].to_set
    end
  end
end
