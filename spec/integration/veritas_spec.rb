require 'spec_helper'
require 'mapper/veritas'

# This is a spike. 

# Im about to move some of this classes into lib with specs and docs.

describe Mapper,'veritas integration' do
  class ObjectReader
    include Enumerable

    def initialize(reader)
      @reader = reader
    end

    def each
      return to_enum(__method__) unless block_given?

      @reader.each do |loader|
        yield loader.object
      end
    end
  end

  class SomeVeritasUser
    include Virtus::ValueObject

    attribute :id,Integer
    attribute :firstname,String
    attribute :lastname,String

    Mapper = Mapper::Veritas.build(self) do
      map :id
      map :firstname
      map :lastname

      data =
        [
          [1,'Markus','Schirp'],
          [2,'John',  'Doe']
        ]

      relation(
        ::Veritas::Relation.new(build_header,data.to_enum)
      )
    end
  end

  let(:reader) do
    SomeVeritasUser::Mapper.reader
  end

  it 'can read all objects' do
    ObjectReader.new(reader).to_a.size.should == 2
  end

  it 'can read some objects' do
    ObjectReader.new(reader.restrict { |r| r.firstname.eq('John') }).to_a.size.should == 1
  end
end
