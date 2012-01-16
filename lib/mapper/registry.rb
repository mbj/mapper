module Mapper
  # A simple mapper registry subjected to be used as root of a mapper hierarchy.
  class Registry
    # Adds a mapper
    #
    # @param [Object, #model] mapper to be added for model
    # @return self
    def add_mapper(mapper)
      @mappers[mapper.model]=mapper

      self
    end
    alias :[]= :add_mapper
   
    # Find a mapper for given model.
    #
    # @param [Object] the model to find the mapper for.
    # @raise [ArgumentError] if model is not mapped.
    # @return [Object, #dump, #load] mapper for model.
    def mapper(model)
      @mappers.fetch(model) do
        raise ArgumentError,"missing mapper for #{model.inspect}"
      end
    end
    alias :[] :mapper

  protected

    # Initialize a jet empty registry.
    def initialize
      @mappers = {}
    end
  end
end
