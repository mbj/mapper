module Mapper
  class Mapper
    attr_reader :name
   
    def initialize(name)
      @name = name
    end
   
    def dump(object)
      raise NotImplemented,'must be implemented in subclasses'
    end
   
    def load(object)
      raise NotImplemented,'must be implemented in subclasses'
    end
  end
end
