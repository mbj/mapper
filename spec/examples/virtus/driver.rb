require 'virtus'
module Examples
  module Virtus

    class Address
      include ::Virtus
      attribute :address_line,String
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
    end
  end
end
