require 'spec_helper'

describe Mapper::Transformer::Loader,'#attributes' do

  let(:mapper) do 
    ::Mapper.new do
      map :foo, Object, :to => :other
    end
  end

  let(:described_class) { mapper::Loader            }
  let(:object)          { described_class.new(dump) }
  let(:dump)            { { :other => :bar }        }

  subject { object.attributes }

  before do
    object.stub(:mapper => mapper)
  end

  it { should == { :foo => :bar } }
end
