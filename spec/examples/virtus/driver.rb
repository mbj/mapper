#encoding: utf-8
require 'virtus'
module Examples
  module Virtus

    class Address
      include ::Virtus
      attribute :line,String
      attribute :country,String
      attribute :postcode,String
      attribute :city,String
    end
   
    class Placement
      include ::Virtus
      attribute :rank,Integer
      attribute :name,String
    end
    
    class Driver
      include ::Virtus
      attribute :greeting,String
      attribute :firstname,String
      attribute :lastname,String
      attribute :address,Address
      # Virtus currently does not have some kind of "typed array" 
      # so using plain arrays here.
      attribute :placements,Array

      def placements=(placement_attributes)
        placements = placement_attributes.map do |attributes|
          if attributes.kind_of?(Placement)
            attributes
          else
            Placement.new(attributes)
          end
        end
        super(placements)

        self
      end

      def self.example
        Driver.new(
          :greeting  => 'Mr',
          :firstname => 'John',
          :lastname  => 'Doe',
          :placements => [
            Placement.new(
              :rank => 2,
              :name => 'Stadrrundfahrt Oberhausen'
            ),
            Placement.new(
              :rank => 20,
              :name => 'Rü Cup Essen'
            )
          ],
          :address => Address.new(
            :line         => 'Zum verrückten Fahrradfahrer 1',
            :postcode     => '0815',
            :city         => 'Musterstadt'
          )
        )
      end
    end
  end
end
