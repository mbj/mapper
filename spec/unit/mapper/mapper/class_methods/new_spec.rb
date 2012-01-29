require 'spec_helper'

describe Mapper::Mapper,'.new' do
  subject { described_class.new(*arguments) }

  context 'with name given' do
    let(:arguments) { [:name] }
    it 'should store name' do
      subject.name.should == :name
    end

    it 'should store name as dump_name' do
      subject.dump_name.should == :name
    end
  end

  context 'with name and dump_name as option' do

    let(:arguments) { [:name,{:dump_name => :dump_name}] }

    it 'should store name' do
      subject.name.should == :name
    end

    it 'should store dump name from options' do
      subject.dump_name.should == :dump_name
    end
  end
end
