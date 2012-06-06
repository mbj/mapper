require 'spec_helper'

describe Mapper::Transformer::Dumper,'#dumped' do
  let(:domain_object) do 
    Object.new.extend(Module.new do
      def foo
        :bar
      end
    end)
  end

  let(:mapper) do 
    ::Mapper.new do
      map :foo, Object
    end
  end

  let(:described_class) { mapper::Dumper                     }
  let(:object)          { described_class.new(domain_object) }

  subject { object.dumped }

  before do
    object.stub(:mapper => mapper)
  end


  it 'should return dumped object' do
    should == { :foo => :bar }
  end
end
