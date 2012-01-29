require 'spec_helper'

describe Mapper::Mapper::Collection,'.new' do 
  subject { described_class.new(*arguments) }

  context 'with name given' do
    let(:arguments) { [:name] }
    it 'should raise an exception about missing mapper' do
      expect do
        subject
      end.to raise_error(ArgumentError,'missing :mapper in +options+')
    end
  end

  context 'with name as argument and mapper given as option' do
    let(:arguments) { [:name,:mapper => :mapper] }

    it 'should store name' do
      subject.name.should == :name
    end

    it 'should store mapper' do
      subject.mapper.should == :mapper
    end

    it 'should store name as dump name' do
      subject.dump_name.should == :name
    end
  end

  context 'with name as argument and mapper, :dump_name given as option' do
    let(:arguments) { [:name,:mapper => :mapper,:dump_name => :dump_name] }

    it 'should store name' do
      subject.name.should == :name
    end

    it 'should store mapper' do
      subject.mapper.should == :mapper
    end

    it 'should store dump name as dump name' do
      subject.dump_name.should == :dump_name
    end
  end
end

