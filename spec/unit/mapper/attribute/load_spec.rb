require 'spec_helper'

describe Mapper::Mapper::Attribute,'#load' do
  let(:object) do
    described_class.new(:a,options)
  end

  let(:options) { {} }

  subject { object.load(dump) }

  context 'with default options' do
    let(:dump) do 
      {
        :a => :value_a,
        :b => :value_b
      }
    end

    it 'should load to name' do
      should == { :a => :value_a }
    end
  end

  context 'with :as => :field_name' do
    let(:options) {{ :as => :field_name }}

    let(:dump) do 
      {
        :field_name => :value_a,
        :b => :value_b
      }
    end

    it 'should load to :a' do
      should == { :a => :value_a }
    end
  end
end
