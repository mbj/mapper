class Driver
  include Virtus

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

  attribute :greeting,String
  attribute :firstname,String
  attribute :lastname,String
  attribute :category,String
  attribute :events,Array
end
