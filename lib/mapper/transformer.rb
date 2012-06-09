module Mapper
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

    # Access transformers class mapper
    #
    # @raise [RuntimeError] 
    #   when no mapper was set
    #
    # @return [Mapper]
    #
    # @api private
    #
    def self.mapper
      @mapper || raise("mapper setup missing")
    end

    # Access transformers mapper
    #
    # @return [Mapper]
    #
    # @api private
    #
    def mapper
      self.class.mapper
    end

  private

    # Initialize transformer with source
    #
    # @param [Object] source
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(source,operations)
      @source,@operations = source,operations
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
      @operations.execute(name,@source)
    end
  end
end
