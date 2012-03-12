require 'spec_helper'

require 'mapper/mongo'
require 'mapper/virtus'

require 'logger'

# A plain mongo integration without using veritas

describe 'mongo integration' do
  class Person
    # Using ValueObject here to simply testing!
    include Virtus
    attribute :id, BSON::ObjectId,:default => proc { BSON::ObjectId.new }
    attribute :firstname,String
    attribute :lastname,String

    def ==(other)
      raise if other.eql?(self)
      other.attributes == attributes
    end
  end

  let(:person) do
    Person.new(
      :firstname => 'John',
      :lastname => 'Doe'
    )
  end

  let(:person_mapper) do
    Mapper::Mapper::Virtus.new(
      Person,
      [
        Mapper::Mapper::Attribute.new(:id,:as => :_id),
        Mapper::Mapper::Attribute.new(:firstname),
        Mapper::Mapper::Attribute.new(:lastname),
      ]
    )
  end

  let(:db) do
    connection = ::Mongo::ReplSetConnection.new(
      ['helium:27017'],
      :safe => true,
      :logger => Logger.new($stdout,Logger::DEBUG)
    )
    connection.add_auth('mapper_development','mapper_development','TIdXLOHf9isf83PHzdu3wohk')
    connection.db('mapper_development')
  end

  let(:people_collection) do
    db.collection(:people)
  end

  let(:mapper) do
    Mapper::Mapper::Mongo.new(
      :mapper => person_mapper,
      :collection => people_collection
    )
  end

  before do
    people_collection.remove({})
  end

  specify 'allows to insert objects' do
    mapper.insert_object(person)

    people_collection.find_one.should == {
      '_id' => person.id,
      'firstname' => person.firstname,
      'lastname' => person.lastname
    }
  end

  specify 'allows to insert dumps' do
    mapper.insert_dump(mapper.dump(person))

    people_collection.find_one.should == {
      '_id' => person.id,
      'firstname' => person.firstname,
      'lastname' => person.lastname
    }
  end

  specify 'allows to delete objects' do
    mapper.insert_object(person)

    mapper.delete_object(person)

    people_collection.count.should be_zero
  end

  specify 'allows to delete keys' do
    mapper.insert_object(person)

    key = mapper.dump_key(person)

    mapper.delete_key(key)

    people_collection.count.should be_zero
  end

  specify 'allows to read dumps via query' do
    mapper.insert_object(person)

    enumerator = mapper.read_dumps({})

    enumerator.to_a.should == [mapper.dump(person)]
  end

  specify 'allows to read dumps via cursor' do
    mapper.insert_object(person)

    cursor = people_collection.find({})

    enumerator = mapper.read_dumps(cursor)

    enumerator.to_a.should == [mapper.dump(person)]
  end

  specify 'allows to read objects via query' do
    mapper.insert_object(person)

    enumerator = mapper.read_objects({})

    enumerator.to_a.should == [person]
  end

  specify 'allows to read objects via cursor' do
    mapper.insert_object(person)

    cursor = people_collection.find({})

    enumerator = mapper.read_objects(cursor)

    enumerator.to_a.should == [person]
  end

  specify 'allows to update via object' do
    mapper.insert_object(person)

    person.firstname = 'Snake'
    person.lastname = 'Oil'

    mapper.update_object(person)

    people_collection.find_one.should == {
      '_id' => person.id,
      'firstname' => 'Snake',
      'lastname' => 'Oil'
    }
  end

  specify 'allows to update via dump' do
    mapper.insert_object(person)

    person.firstname = 'Snake'
    person.lastname = 'Oil'

    dump = mapper.dump(person)

    mapper.update_dump(mapper.dump_key(person),dump)

    people_collection.find_one.should == {
      '_id' => person.id,
      'firstname' => 'Snake',
      'lastname' => 'Oil'
    }
  end

  specify 'allows to update differencial via dump' do
    mapper.insert_object(person)

    dump_before = mapper.dump(person)

    person.firstname = 'Snake'

    dump = mapper.dump(person)

    key = mapper.load_key(dump_before)

    mapper.update_dump(mapper.load_key(dump_before),dump,dump_before)

    people_collection.find_one.should == {
      '_id' => person.id,
      'firstname' => 'Snake',
      'lastname' => 'Doe'
    }

    collection = mock

    people_collection.should_receive(:update).
      with(key,{ :$set => { :firstname => 'Snake'} })

    mapper.update_dump(mapper.load_key(dump_before),dump,dump_before)
  end
end
