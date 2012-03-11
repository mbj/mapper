require 'spec_helper'

describe Mapper::Mapper::Attribute,'#dump' do
  let(:object) do
    described_class.new(:a,options)
  end

  let(:options) { {} }

  subject { object.dump(value) }

  context 'with default options' do
    let(:value) do 
      {
        :a => :value_a,
        :b => :value_b
      }
    end

    it 'should dump to name' do
      should == { :a => :value_a }
    end
  end

  context 'with :as => :field_name' do
    let(:options) {{ :as => :field_name }}

    let(:value) do 
      {
        :a => :value_a,
        :b => :value_b
      }
    end

    it 'should dump to :field_name' do
      should == { :field_name => :value_a }
    end
  end
end
