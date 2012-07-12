require 'spec_helper'

describe Mapper::Veritas::Reader, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  class FakeLoader
    include Virtus::ValueObject
    attribute :dump, Array
  end

  class FakeMapper
    def loader(dump)
      FakeLoader.new(:dump => dump)
    end
  end

  let(:object)   { described_class.new(mapper, relation) }
  let(:yields)   { []                                   }
  let(:relation) { [[1], [2]]                            }
  let(:mapper)   { FakeMapper.new                       }

  it_should_behave_like 'an #each method'

  it 'yields each loader' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to(relation.map { |dump| FakeLoader.new(:dump => dump) })
  end
end
