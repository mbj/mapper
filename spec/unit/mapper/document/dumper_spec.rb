require 'spec_helper'

describe Mapper::Document, '#dumper' do
  subject { object.dumper(domain_object) }

  let(:object) do
    described_class.build(DomainObject) do 
      map :id, :key => true
      map :foo
    end
  end

  let(:domain_object) { DomainObject.new(:id => 1, :foo => :bar) }

  it { should be_a(Mapper::Transformer::Dumper) }

  its(:source) { should be(domain_object) }
  its(:source) { should respond_to(:id) }
  its(:source) { should respond_to(:foo) }

  its(:dump)   { should == { :id => 1, :foo => :bar } }
  its(:key)    { should == { :id => 1 }               }
end
