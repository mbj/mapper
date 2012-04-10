require 'spec_helper'

describe Mapper::Mapper::EmbeddedDocument,'#load' do
  let(:embedded_mapper) do
    object = Object.new
    class << object
      def load(dump)
        dump
      end
    end
    object
  end

  let(:object) do
    described_class.new(:a,options)
  end

  let(:options) { { :mapper => embedded_mapper } }

  let(:field_name) { :a }

  let(:dump) do
    {
      field_name => { :some => :random_document },
      :b => :value_b
    }
  end

  subject { object.load(dump) }

  context 'with default options' do

    it 'should load embedded document' do
      should == { :a => { :some => :random_document } }
    end

  end

  context 'with :as => :field_name' do
    let(:field_name) { :field_name }
    let(:options) {{ :mapper => embedded_mapper, :as => :field_name }}

    it 'should load embedded document' do
      should == { :a => { :some => :random_document } }
    end

  end

  context 'when dump does not include field with name' do
    let(:field_name) { :foo }

    it 'should load nil' do
      should == { :a => nil }
    end

    it 'should not pass nil to embedded_mapper#load' do
      embedded_mapper.should_not_receive(:load)
      subject
    end
  end

  context 'when embedded mapper modifies inner object on load' do
    let(:embedded_mapper) do
      object = Object.new
      class << object
        def load(dump)
          :modification
        end
      end
      object
    end

    it 'should pass modification' do
      should == { :a => :modification }
    end
  end
end
