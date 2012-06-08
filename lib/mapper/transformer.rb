module Mapper
  # Base class for loader and dumper classes
  class Transformer
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

    # Collect hash from executing methods on transformer
    #
    # @param [Array] names 
    #   the methods to execute and collect
    #
    # @return [Hash]
    #
    # @api private
    #
    def collect(names)
      names.each_with_object({}) do |name,hash|
        hash[name]=send(name)
      end
    end

    # Access transformer value via memonization guard
    #
    # @param [Symbol] name of value to access
    #
    # @return [Object]
    #
    # @api private
    #
    def memonize(name)
      @memonized ||= {}
      @memonized.fetch(name) do
        @memonized[name]=yield
      end
    end

    # Resolve attribute via dump name
    #
    # @param [Symbol] name
    #
    # @return [Attribute]
    #
    # @api private
    def attribute(name)
      mapper.attribute_for_dump_name(name)
    end
  end
end
