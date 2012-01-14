module Mapper
  class Mapper
    def initialize
      @models = {}
    end

    def dump(object)
      fetch_model(object.class).dump(object)
    end

    def load(model,object)
      fetch_model(model).load(object)
    end

    def map_model(model,options={})
      model_mapper(ModelMapper.new(model,options))
    end

    def model_mapper(mapper)
      @models[mapper.model]=mapper
    end

    def fetch_model(model)
      model = @models.fetch(model) do
        raise ArgumentError,"missing mapping model for: #{model.inspect}"
      end
    end

    def repository_name(model)
      fetch_model(model).repository_name
    end
  end
end
