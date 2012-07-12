require 'spec_helper'

describe Mapper::Veritas, '#loader' do
  subject { object.loader(tuple) }

  let(:object) do
    mapped_relation = self.relation

    described_class.build(DomainObject) do 
      map :id,  :key => true
      map :foo

      relation(mapped_relation)
    end
  end


  let(:tuple) do 
    Veritas::Tuple.new(header, [1, :bar])
  end

  let(:relation) do
    Veritas::Relation.new(header, data)
  end

  let(:header) do
    Veritas::Relation::Header.new([ [ :id, Integer ], [ :foo, String ] ])
  end

  let(:data) { [].to_enum }

  it { should be_a(Mapper::Transformer::Loader) }

  its(:source) { should be_kind_of(Mapper::Veritas::DumpWrapper) }

  its(:key)    { should == { :id => 1 } }

  its(:object) { should be_kind_of(DomainObject) }
  its(:object) { subject.id.should be(1) }
  its(:object) { subject.foo.should be(:bar) }
end
