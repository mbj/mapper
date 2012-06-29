class Mapper
  # A builder object that creates mappers
  class Builder
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
    def self.run(mapper_class,model,&block)
      raise ArgumentError, 'Need a block to build mapper' unless block_given?

      builder = new(mapper_class,model)
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
      @mapper_class.new(@model,attributes)
    end

    # Declare a mapping between attribute and database
    #
    # @param [Symbol] name
    #   the name of the attribute
    #
    # @param [Class] attribute_class
    #   the klass of the mapping
    #
    # @param [Options] options
    #   the options for this mapping
    #
    # @return [self]
    #
    # @api private
    #
    def map(name,attribute_class,options={})
      attribute = Attribute.build(name,attribute_class,options)
      attributes.add(attribute)

      self
    end

  private

    # Initialize mapper builder
    #
    # @param [Class<Mapper>] mapper_class
    # @param [Object] model
    #
    # @api private
    #
    # @return [undefined]
    #
    def initialize(mapper_class,model)
      @mapper_class, @model = mapper_class,model
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

    # Lookup a missing constant
    #
    # @return [Class]
    #
    # @api private
    #
    def const_missing(name)
      Attribute.determine_type(name) || super
    end
  end
end
