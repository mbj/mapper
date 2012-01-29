# encoding: utf-8
# this is a spike spec to experiment with the interface
# Will/should be transferred into an integration spec.
require 'spec_helper'

describe 'building a mapper for virtus with EV and embedded collection' do

  let(:object) do
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


  context 'when mapping to EV and EC at a default repository' do
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

    it 'should map to internal representation' do
      driver_mapper.dump(object).should == internal
    end

    it 'should round trip internal representation' do
      driver_mapper.dump(driver_mapper.load(internal)).should == internal
    end
  end
end
