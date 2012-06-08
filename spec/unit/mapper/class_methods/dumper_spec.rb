require 'spec_helper'

describe Mapper::ClassMethods,'#dumper' do
  let(:domain_object) { DomainObject.new(:foo => :bar) } 

  let(:described_class) do
    ::Mapper.new do
      map :foo, Object
    end
  end

  let(:object) { described_class }

  subject { object.dumper(domain_object) }

  its(:class) { should == described_class::Dumper }
  its(:source)  { should == domain_object }
end
