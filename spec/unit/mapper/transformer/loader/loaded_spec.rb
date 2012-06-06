require 'spec_helper'

describe Mapper::Transformer::Loader,'#loaded' do
  let(:model) do
    Class.new do
      attr_reader :foo
      def initialize(attributes)
        @foo = attributes.fetch(:foo)
      end
    end
  end

  let(:mapper) do 
    model = self.model
    ::Mapper.new do
      model(model)
      map :foo, Object
    end
  end

  let(:described_class) { mapper::Loader            }
  let(:object)          { described_class.new(dump) }
  let(:dump)            { { :foo => :bar }          }

  subject { object.loaded }

  before do
    object.stub(:mapper => mapper)
  end

  it 'should be kind of domain model' do
    should be_kind_of(model)
  end

  its(:foo) { should be(:bar) }
end
