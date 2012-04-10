require 'spec_helper'

describe Mapper::Mapper::EmbeddedDocument,'#dump' do
  let(:embedded_mapper) do
    object = Object.new
    class << object
      def dump(value)
        value
      end
    end
    object
  end

  let(:object) do
    described_class.new(:a,options)
  end

  let(:options) { { :mapper => embedded_mapper } }

  let(:value) do
    {
      :a => { :some => :random_document },
      :b => :value_b
    }
  end

  subject { object.dump(value) }

  context 'with default options' do

    it 'should dump to name' do
      should == { :a => { :some => :random_document } }
    end

  end

  context 'with :as => :field_name' do
    let(:options) {{ :mapper => embedded_mapper, :as => :field_name }}

    it 'should dump to :field_name' do
      should == { :field_name => { :some => :random_document } }
    end

  end

  context 'when value is nil' do
    let(:value) { nil }
    it 'should dump to nil value' do
      should == { :a => nil }
    end

    it 'should not pass nil to embedded_mapper#dump' do
      embedded_mapper.should_not_receive(:dump)
      subject
    end
  end

  context 'when embedded mapper modifies inner object' do
    let(:embedded_mapper) do
      object = Object.new
      class << object
        def dump(value)
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
