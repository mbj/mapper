require 'spec_helper'
require 'mapper/veritas'

# This is a spike. 

# Im about to move some of this classes into lib with specs and docs.

describe Mapper,'veritas integration' do
  class Reader
    include Enumerable

    def initialize(mapper,relation)
      @mapper, @relation = mapper,relation
    end

    def each
      return to_enum(__method__) unless block_given?

      @relation.each do |tuple|
        yield @mapper.loader(tuple)
      end
    end

    def objects
      ObjectReader.new(self)
    end

  private

    def method_missing(method,*args,&block)
      forwardable?(method) ? forward(method,args,block) : super
    end

    def forward(method,args,block)
      result = @relation.send(method,*args,&block)

      unless result.kind_of?(Veritas::Relation)
        return result
      end

      self.class.new(@mapper,result)
    end

    def forwardable?(method)
      @relation.respond_to?(method)
    end
  end

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

      header = [
        [ :id, ::Integer ],
        [ :firstname, ::String ],
        [ :lastname, ::String ]
      ]

      relation(
        ::Veritas::Relation.new(header,data.to_enum)
      )
    end
  end

  let(:reader) do
    SomeVeritasUser::Mapper.reader
  end

  it 'can read all objects' do
    reader.objects.to_a.size.should == 2
  end

  it 'can read some objects' do
    reader.restrict { |r| r.firstname.eq('John') }.objects.to_a.size.should == 1
  end
end
