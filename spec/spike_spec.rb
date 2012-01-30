# encoding: utf-8
# this is a spike spec to experiment with the interface
# Will/should be transferred into an integration spec.
require 'spec_helper'

describe 'building a mapper for virtus with EV and EC (embedded collection)' do

  let(:driver) do
    Examples::Virtus::Driver.new(
      :greeting  => 'Mr',
      :firstname => 'John',
      :lastname  => 'Doe',
      :placements => [
        Examples::Virtus::Placement.new(
          :rank => 2,
          :name => 'Stadrrundfahrt Oberhausen'
        ),
        Examples::Virtus::Placement.new(
          :rank => 20,
          :name => 'Rü Cup Essen'
        )
      ],
      :address => Examples::Virtus::Address.new(
        :address_line => 'Zum verrückten Fahrradfahrer 1',
        :postcode     => '0815',
        :city         => 'Musterstadt'
      )
    )
  end

  let(:address_mapper) do
    attributes = [
      Mapper::Mapper::Attribute.new(:address_line),
      Mapper::Mapper::Attribute.new(:postcode),
      Mapper::Mapper::Attribute.new(:city)
    ]

    Mapper::Mapper::Resource.new(
      :address,
      :model => Examples::Virtus::Address,
      :attributes => attributes
    )
  end

  let(:placement_mapper) do
    attributes = [
      Mapper::Mapper::Attribute.new(:rank),
      Mapper::Mapper::Attribute.new(:name)
    ]

    Mapper::Mapper::Resource.new(
      :placement,
      :model => Examples::Virtus::Placement,
      :attributes => attributes
    )
  end

  shared_examples_for 'correct mapping' do
    it 'should dump to internal' do
      mapper.dump(object).should == internal
    end

    it 'should round trip' do
      mapper.dump(mapper.load(internal)).should == internal
    end
  end

  context 'when attribute does dump to another name' do
    let(:mapper) do
      attributes = [
        Mapper::Mapper::Attribute.new(:address_line),
        Mapper::Mapper::Attribute.new(:postcode),
        Mapper::Mapper::Attribute.new(:city,:dump_name => :location)
      ]

      Mapper::Mapper::Resource.new(
        :address,
        :model => Examples::Virtus::Address,
        :attributes => attributes
      )
    end

    let(:object) { driver.address }

    let(:internal) do
      {
        :address_line => 'Zum verrückten Fahrradfahrer 1',
        :postcode     => '0815',
        :location     => 'Musterstadt'
      }
    end

    it_should_behave_like 'correct mapping'
  end


  context 'when mapping to EV and EC' do

    let(:driver_mapper) do
      attributes = [
        Mapper::Mapper::Attribute.new(:greeting),
        Mapper::Mapper::Attribute.new(:firstname),
        Mapper::Mapper::Attribute.new(:lastname),
        address_mapper,
        Mapper::Mapper::Collection.new(
          :placements, 
          :mapper => placement_mapper
        )
      ]
    
      Mapper::Mapper::Resource.new(
        :driver,
        :model => Examples::Virtus::Driver,
        :attributes => attributes
      )
    end

    let(:internal) do
      {
        :greeting   => 'Mr',
        :firstname  => 'John',
        :lastname   => 'Doe',
        :address => {
          :address_line => 'Zum verrückten Fahrradfahrer 1',
          :postcode     => '0815',
          :city         => 'Musterstadt'
        },
        :placements => [{
          :rank => 2,
          :name => 'Stadrrundfahrt Oberhausen',
        },{
          :rank => 20,
          :name => 'Rü Cup Essen'
        }]
      }
    end

    let(:mapper) { driver_mapper }
    let(:object) { driver }

    it_should_behave_like 'correct mapping'
  end
end
