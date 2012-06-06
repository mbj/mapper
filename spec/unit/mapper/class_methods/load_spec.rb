require 'spec_helper'

describe Mapper::ClassMethods,'#load' do
  let(:domain_model) do 
    Class.new do
      attr_reader :foo

      def initialize(attributes)
        @foo = attributes.fetch(:foo)
      end
    end
  end

  let(:described_class) do
    model = self.domain_model
    ::Mapper.new do
      model(model)
      map :foo, Object
    end
  end

  let(:object) { described_class }

  let(:dump)   { { :foo => :bar } }

  subject { object.load(dump) }

  its(:class) { should == domain_model }
  its(:foo)   { should == :bar }
end
