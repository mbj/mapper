# encoding: utf-8
# this is a spike spec to experiment with the interface
# Will/should be transferred into an integration spec.
require 'spec_helper'

# FIXME: 
#
#   name of the resource mappers is used as collection name
#   maybe the resource mapper should just be renamed to collection?
#
#   There is no support for keys currently.

describe 'building an attribute tree in differend ways' do
  # This is the complex resource beeing mapped to the database 
  # with multiple patterns.
  #
  # I opted out for POROS here since hashes of hashes/arrays 
  # can easily be build from DM / Virtus / AR.
  let(:driver) do
    {
      :greeting=>'Mr', 
      :firstname=>'John', 
      :lastname=>'Doe', 
      :address=> address,
      :placements=>[
        {
          :rank=>2, 
          :name=>'Stadrrundfahrt Oberhausen', 
        },
        {
          :rank=>20, 
          :name=>'Rü Cup Essen'
        }
      ]
    }
  end

  # Easy resouce
  let(:address) do
    {
      :line=>'Zum verrückten Fahrradfahrer 1',
      :postcode=>'0815', 
      :city=>'Musterstadt'
    }
  end

  # A simple 1:1 mapper for address used later to build more complex ones.
  let(:address_mapper) do
    attributes = [
      Mapper::Mapper::Attribute.new(:line),
      Mapper::Mapper::Attribute.new(:postcode),
      Mapper::Mapper::Attribute.new(:city)
    ]

    Mapper::Mapper::Resource.new(:address,attributes)
  end

  # A simple mapper for ONE placement
  let(:placement_mapper) do
    attributes = [
      Mapper::Mapper::Attribute.new(:rank),
      Mapper::Mapper::Attribute.new(:name)
    ]

    Mapper::Mapper::Resource.new(:placement,attributes)
  end

  shared_examples_for 'a correct mapping' do
    it 'should dump to internal' do
      mapper.dump(object).should == internal
    end

    it 'should load' do
      mapper.load(internal).should == object
    end

    it 'should round trip' do
      mapper.dump(mapper.load(internal)).should == internal
    end
  end

  context 'when attribute does dump to another name' do
    let(:mapper) do
      attributes = [
        Mapper::Mapper::Attribute.new(:line),
        Mapper::Mapper::Attribute.new(:postcode),
        Mapper::Mapper::Attribute.new(:city,:as => :location)
      ]

      Mapper::Mapper::Resource.new(:address,attributes)
    end

    let(:object) { address }

    let(:internal) do
      { 
        :address => {
          :line=>'Zum verrückten Fahrradfahrer 1',
          :postcode=>'0815', 
          :location=>'Musterstadt'
        }
      }
    end

    it_should_behave_like 'a correct mapping'
  end

  context 'when mapping to embedded value' do
    let(:internal) do
      { 
        :drivers => {
          :greeting         => 'Mr',
          :firstname        => 'John',
          :lastname         => 'Doe',
          :address_line     => 'Zum verrückten Fahrradfahrer 1',
          :address_postcode => '0815',
          :address_city     => 'Musterstadt'
        }
      }
    end

    let(:mapper) do
      attributes = [
        Mapper::Mapper::Attribute.new(:greeting),
        Mapper::Mapper::Attribute.new(:firstname),
        Mapper::Mapper::Attribute.new(:lastname),
        Mapper::Mapper::EmbeddedValue.new(
          :address,
          :mapper => address_mapper
        )
      ]

      Mapper::Mapper::Resource.new(:drivers,attributes)
    end

    let(:object) do 
      driver.delete(:placements)
      driver
    end

    it_should_behave_like 'a correct mapping'
  end


  context 'when mapping to embedded document' do
    let(:internal) do
      { 
        :drivers => {
          :greeting   => 'Mr',
          :firstname  => 'John',
          :lastname   => 'Doe',
          :address    => address,
        }
      }
    end

    let(:mapper) do
      attributes = [
        Mapper::Mapper::Attribute.new(:greeting),
        Mapper::Mapper::Attribute.new(:firstname),
        Mapper::Mapper::Attribute.new(:lastname),
        Mapper::Mapper::EmbeddedDocument.new(
          :address,
          :mapper => address_mapper
        )
      ]
    
      Mapper::Mapper::Resource.new(:drivers,attributes)
    end

    let(:object) do 
      driver.delete(:placements)
      driver
    end

    it_should_behave_like 'a correct mapping'
  end

  context 'when mapping to embedded collection' do
    let(:object) do 
      driver.delete(:address)
      driver
    end

    let(:mapper) do
      attributes = [
        Mapper::Mapper::Attribute.new(:greeting),
        Mapper::Mapper::Attribute.new(:firstname),
        Mapper::Mapper::Attribute.new(:lastname),
        Mapper::Mapper::EmbeddedCollection.new(
          :placements,
          :mapper => placement_mapper
        )
      ]
    
      Mapper::Mapper::Resource.new(:drivers,attributes)
    end

    let(:internal) do
      { 
        :drivers => {
          :greeting   => 'Mr',
          :firstname  => 'John',
          :lastname   => 'Doe',
          :placements=>[
            {
              :rank=>2, 
              :name=>'Stadrrundfahrt Oberhausen', 
            },
            {
              :rank=>20, 
              :name=>'Rü Cup Essen'
            }
          ]
        }
      }
    end

    it_should_behave_like 'a correct mapping'
  end

  context 'when mapping address to multiple collections' do
    let(:mapper) do
      # This looks stupid, but I do not think users will have 
      # to build this trees by hand. (DSL?)
      Mapper::Mapper::Root.new(:address,
        [
          Mapper::Mapper::Repository.new(:default,
            [
              Mapper::Mapper::Resource.new(:address_a,
                [
                  Mapper::Mapper::Attribute.new(:line),
                  Mapper::Mapper::Attribute.new(:postcode)
                ]
              ),
              Mapper::Mapper::Resource.new(:address_b,
                [
                  Mapper::Mapper::Attribute.new(:city)
                ]
              )
            ]
          ),
        ]
      )
    end

    let(:object) { address }

    let(:internal) do
      {
        :default => {
          :address_a => {
            :line => address.fetch(:line),
            :postcode => address.fetch(:postcode),
          },
          :address_b => {
            :city => address.fetch(:city)
          }
        }
      }
    end

    it_should_behave_like 'a correct mapping'
  end


 #context 'when mapping to repository' do

 #  let(:repository_mapper) do
 #    Mapper::Mapper::Repository.new(:default,[driver_mapper])
 #  end

 #  let(:root_mapper) do
 #    Mapper::Mapper::Root.new(:default,[repository_mapper])
 #  end

 #  let(:internal) do
 #    {
 #      :default => {
 #        :drivers => driver_internal
 #      }
 #    }
 #  end

 #  let(:mapper) { root_mapper }
 #  let(:object) { driver }

 #  it_should_behave_like 'a correct mapping'
 #end
end
