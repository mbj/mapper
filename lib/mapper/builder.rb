class Mapper
  # A builder object that creates mappers
  class Builder
    # Error raised when builder attemts to build incomplete mappers
    class IncompleteMapperError < RuntimeError; end

    # Run mapper builder
    #
    # @param [Class<Mapper>] mapper_class
    #   the class of the mapper to build
    #
    # @param [Object] model
    #   the model this mapper is build for
    #
    # @return [Mapper]
    #
    # @api private
    #
    def self.run(mapper_class, model, &block)
      raise ArgumentError, 'Need a block to build mapper' unless block_given?

      builder = new(mapper_class, model)
      builder.instance_eval(&block)

      builder.mapper
    end

    # Return new mapper
    #
    # @return [Mapper]
    #
    # @api private
    #
    def mapper
      @mapper_class.new(@model, attributes)
    end

    # Declare a mapping between attribute and database
    #
    # @param [Symbol] name
    #   the name of the attribute
    #
    # @param [Options] options
    #   the options for this mapping
    #
    # @return [self]
    #
    # @api private
    #
    def map(name, options={})
      attribute = Attribute.build(name, options)
      attributes.add(attribute)

      self
    end

    # Customize dumper via block
    #
    # @return [self]
    #
    # @api private
    #
    def dumper(&block)
      dumper_class.class_eval(&block)

      self
    end

    # Customize dumper via block
    #
    # @return [self]
    #
    # @api private
    #
    def loader(&block)
      loader_class.class_eval(&block)

      self
    end

  private

    # Return dumper class
    #
    # @api private
    #
    # @return [Class]
    #
    def dumper_class
      attributes.dumper_class
    end

    # Return loader class
    #
    # @api private
    #
    # @return [Class]
    #
    def loader_class
      attributes.loader_class
    end

    # Initialize mapper builder
    #
    # @param [Class<Mapper>] mapper_class
    # @param [Object] model
    #
    # @api private
    #
    # @return [undefined]
    #
    def initialize(mapper_class, model)
      @mapper_class, @model = mapper_class, model
    end

    # Return attribute set
    #
    # @return [AttributeSet]
    #
    # @api private
    #
    def attributes
      @attributes ||= AttributeSet.new
    end
  end
end
