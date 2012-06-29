require 'spec_helper'

describe Mapper::Document,'#loader' do
  subject { object.loader(dump) }

  let(:object) do
    described_class.build(DomainObject) do 
      map :id,  Object, :key => true
      map :foo, Object
    end
  end

  let(:dump) { { :id => 1, :foo => :bar } }

  it { should be_a(Mapper::Transformer::Loader) }

  its(:source) { should be_kind_of(Mapper::Document::DumpWrapper) }

  its(:key)    { should == { :id => 1 } }
  its(:object) { should be_kind_of(DomainObject) }

  its(:object) { subject.id.should be(1) }
  its(:object) { subject.foo.should be(:bar) }
end
