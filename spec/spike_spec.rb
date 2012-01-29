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

  context 'when mapping to EV and EC at a default repository' do

    let(:address_mapper) do
      attributes = [
        Mapper::Mapper::Attribute.new(:address_line),
        Mapper::Mapper::Attribute.new(:postcode),
        Mapper::Mapper::Attribute.new(:city)
      ]

      Mapper::Mapper::Resource.new(:address,Examples::Virtus::Address,attributes)
    end

    let(:placement_mapper) do
      attributes = [
        Mapper::Mapper::Attribute.new(:rank),
        Mapper::Mapper::Attribute.new(:name)
      ]

      Mapper::Mapper::Resource.new(:placement,Examples::Virtus::Placement,attributes)
    end

    let(:driver_mapper) do
      attributes = [
        Mapper::Mapper::Attribute.new(:greeting),
        Mapper::Mapper::Attribute.new(:firstname),
        Mapper::Mapper::Attribute.new(:lastname),
        Mapper::Mapper::EmbeddedValue.new(:address,address_mapper),
        Mapper::Mapper::EmbeddedCollection.new(:placements,placement_mapper)
      ]

      Mapper::Mapper::Resource.new(:driver,Examples::Virtus::Address,attributes)
    end

    let(:intern) do
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

    it 'should map to intern representation' do
      driver_mapper.dump(object).should == intern
    end
  end
end
