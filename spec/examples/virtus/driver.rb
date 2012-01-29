class Driver
  include Virtus

  class Address
    include Virtus
    attribute :address_line,String
    attribute :country,String
    attribute :postcode,String
  end

  # Virtus does not have some kind of "typed array jet" 
  # so using plain arrays here.
  class Placement
    include Virtus
    attribute :number,String
    attribute :name,String
  end
  
  class Event
    include Virtus
    attribute :name,String
    attribute :placements,Array
  end

  attribute :address,Address
  attribute :greeting,String
  attribute :firstname,String
  attribute :lastname,String
  attribute :category,String
  attribute :events,Array
end
