module Mapper
  class Registry
    def initialize
      @data = {}
    end

    def register(model,mapper)
      @data[model] = mapper

      self
    end

    def for(model)
      @data.fetch(model)
    end

    def dump(object)
      self.for(object.class).dump(object)
    end

    def dump_key(object)
      self.for(object.class).dump_key(object)
    end

    def load(model,dump)
      self.for(model).load(dump)
    end
  end
end
