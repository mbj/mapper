class Mapper
  # Base class for loader and dumper classes
  class Transformer
    extend ReaderDefiner

    # Return source of transformation
    #
    # @return [Object]
    #
    # @api private
    #
    def source
      @source
    end

    # Return key
    #
    # @return [Object]
    #
    # @api private
    #
    def key
      @key ||= map(operations.keys)
    end

  private

    # Initialize transformer
    #
    # @param [Mapper] mapper
    # @param [Object] source
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(mapper,source)
      @mapper,@source = mapper,source
    end

    # Create hash from executing methods on transformer
    #
    # @param [Array] names 
    #   the methods to execute and map
    #
    # @return [Hash]
    #
    # @api private
    #
    def map(names)
      names.each_with_object({}) do |name,hash|
        hash[name]=send(name)
      end
    end

    # Return transformed value via memonization guard
    #
    # @param [Symbol] name of value to return
    #
    # @return [Object]
    #
    # @api private
    #
    def read(name)
      @memonized ||= {}
      @memonized.fetch(name) do
        @memonized[name]=read_nocache(name)
      end
    end

    # Return transformed value
    #
    # @param [Symbol] name of value to return
    #
    # @return [Object]
    #
    # @api private
    #
    def read_nocache(name)
      operations.execute(name,@source)
    end

    # Return attributes
    #
    # @return [AttributeSet]
    #
    # @api private
    #
    def mapper_attributes
      @mapper.attributes
    end

    # Return operations
    #
    # @return [AttributeSet::Operations]
    #
    # @api private
    def operations
      raise NotImplementedError,"#{self.class}#operations must be implemented"
    end
  end
end
