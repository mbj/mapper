module Mapper
  class Mapper
    def dump(object)
      raise NotImplemented,'must be implemented in subclasses'
    end
   
    def load(dump)
      raise NotImplemented,'must be implemented in subclasses'
    end
  end
end
