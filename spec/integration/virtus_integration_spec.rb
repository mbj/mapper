require 'spec_helper'

require 'mapper/virtus'

describe 'virtus integration' do

  class Person
    include Virtus
    attribute :firstname,String
    attribute :lastname,String
  end


  let(:mapper) do
    Mapper::Mapper::Virtus.new(
      Person,
      [
        Mapper::Mapper::Attribute.new(:firstname),
        Mapper::Mapper::Attribute.new(:lastname)
      ]
    )
  end

  specify 'allows to dump from virtus model' do
    person = Person.new(
      :firstname => 'Markus', 
      :lastname => 'Schirp'
    )
    mapper.dump(person).should == {
      :firstname => 'Markus', 
      :lastname => 'Schirp' 
    }
  end

  specify 'allows to load from dump' do
    dump = {
      :firstname => 'Markus',
      :lastname => 'Schirp'
    }
    resource = mapper.load(dump)
    resource.firstname.should == 'Markus'
    resource.lastname.should == 'Schirp'
  end

  specify 'decouples dump from attribute' do
    dump = {
      :firstname => 'Markus',
      :lastname => 'Schirp'
    }

    resource = mapper.load(dump)

    # inplace modification of dump
    dump.fetch(:firstname).gsub!(/./,'')

    resource.firstname.should == 'Markus'
  end

  specify 'allows to dump to other field name' do
    mapper = Mapper::Mapper::Virtus.new(
      Person,
      [
        Mapper::Mapper::Attribute.new(:firstname),
        Mapper::Mapper::Attribute.new(:lastname,:as => :surname),
      ]
    )
  end

  specify 'decouples attribute from dump' do
    person = Person.new(
      :firstname => 'Markus', 
      :lastname => 'Schirp'
    )
    dump = mapper.dump(person)

    # inplace modification of attribute
    person.firstname.gsub!(/./,'')

    dump.fetch(:firstname).should == 'Markus'
  end
end
