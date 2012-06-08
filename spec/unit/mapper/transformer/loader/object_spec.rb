require 'spec_helper'

describe Mapper::Transformer::Loader,'#object' do

  let(:mapper) do 
    ::Mapper.new do
      model(DomainObject)
      map :foo, Object, :to => :other
    end
  end

  let(:described_class) { mapper::Loader            }
  let(:object)          { described_class.new(dump) }
  let(:dump)            { { :other => :bar }        }

  subject { object.object }

  before do
    object.stub(:mapper => mapper)
  end

  its(:class) { should == DomainObject }
  its(:foo)   { should == :bar }

  it_should_behave_like 'an idempotent method'
end
