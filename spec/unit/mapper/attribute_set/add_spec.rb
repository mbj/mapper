require 'spec_helper'

describe Mapper::AttributeSet,'#add' do
  let(:object)    { described_class.new }
  let(:attribute) { Mapper::Attribute::Object.new(:load_name,:to => :dump_name) }

  subject { object.add(attribute) }

  it_should_behave_like 'a command method'

  it 'should add attribute to load names' do
    subject
    object.load_names.should == [:load_name]
  end

  it 'should add attribute to dump names' do
    subject
    object.dump_names.should == [:dump_name]
  end

  context 'when attribute set is not empty' do
    before do
      object.add(Mapper::Attribute::Object.new(:something))
      # make sure we have a cache
      object.load_names
      object.dump_names
    end

    it_should_behave_like 'a command method'

    it 'should add attribute to load names' do
      subject
      object.load_names.to_set.should == [:something,:load_name].to_set
    end

    it 'should add attribute to dump names' do
      subject
      object.dump_names.to_set.should == [:something,:dump_name].to_set
    end
  end
end
