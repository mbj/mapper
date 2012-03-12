module Mapper
  class Mapper
    def dump(object)
      raise NotImplementedError,'must be implemented in subclasses'
    end
   
    def load(dump)
      raise NotImplementedError,'must be implemented in subclasses'
    end
  end
end
