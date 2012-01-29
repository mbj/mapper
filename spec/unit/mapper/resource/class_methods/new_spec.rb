require 'spec_helper'

describe Mapper::Mapper::Resource,'.new' do 
  subject { described_class.new(*arguments) }

  context 'with name given' do
    let(:arguments) { [:name] }
    it 'should raise an exception about missing model' do
      expect do
        subject
      end.to raise_error(ArgumentError,'missing :model in +options+')
    end
  end

  context 'with name as argument and model given as option' do
    let(:arguments) { [:name,:model => :model] }

    it 'should raise an exception about missing attributes' do
      expect do
        subject
      end.to raise_error(ArgumentError,'missing :attributes in +options+')
    end
  end

  context 'with name as argument and model, attributes as options' do
    let(:arguments) do 
      [
        :name,
        {
          :model => :model,
          :attributes => :attributes
        }
      ]
    end

    it 'should store name' do
      subject.name.should == :name
    end

    it 'should store model' do
      subject.model.should == :model
    end

    it 'should store attributes' do
      subject.attributes.should == :attributes
    end

    it 'should store name as dump name' do
      subject.dump_name.should == :name
    end
  end

  context 'with name as argument and model, attributes as options' do
    let(:arguments) do 
      [:name,
       {
        :model => :model,
        :attributes => :attributes,
       }
      ]
    end

    it 'should store name' do
      subject.name.should == :name
    end

    it 'should store model' do
      subject.model.should == :model
    end

    it 'should store attributes' do
      subject.attributes.should == :attributes
    end

    it 'should store name as dump name' do
      subject.dump_name.should == :name
    end
  end

  context 'with name as argument and model, attributes, dump_name given as option' do
    let(:arguments) do 
      [
        :name,
        {
          :model => :model,
          :attributes => :attributes,
          :dump_name => :dump_name
        } 
      ]
    end

    it 'should store name' do
      subject.name.should == :name
    end

    it 'should store model' do
      subject.model.should == :model
    end

    it 'should store attributes' do
      subject.attributes.should == :attributes
    end

    it 'should store dump name as dump name' do
      subject.dump_name.should == :dump_name
    end
  end
end

