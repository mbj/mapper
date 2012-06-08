require 'spec_helper'

describe Mapper::ClassMethods,'#load' do
  let(:described_class) do
    ::Mapper.new do
      model(DomainObject)
      map :foo, Object
    end
  end

  let(:object) { described_class }

  let(:dump)   { { :foo => :bar } }

  subject { object.load(dump) }

  its(:class) { should == DomainObject }
  its(:foo)   { should == :bar }
end
