module Mapper
  class Mapper
    EMPTY_OPTIONS={}.freeze

    attr_reader :name, :dump_name
   
    def initialize(name,options=EMPTY_OPTIONS)
      @name = name
      @dump_name = options.fetch(:dump_name,name)
    end
   
    def dump(object)
      raise NotImplemented,'must be implemented in subclasses'
    end
   
    def load(object)
      raise NotImplemented,'must be implemented in subclasses'
    end
  end
end
