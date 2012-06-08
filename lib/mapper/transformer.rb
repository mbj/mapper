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

    # Create reader method source
    #
    # @param [Symbol] name
    #   the named value to read
    #
    # @return [String]
    #   the ruby source calling memonized_access(:name)
    #
    # @api private
    #
    def self.reader_method_source(name)
      # comment to keep vim syntax happy
      <<-RUBY
        def #{name}
          memonized(:#{name})
        end
      RUBY
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

    # Access mappers attribute set
    #
    # @return [Mapper::AttributeSet]
    #
    # @api private
    #
    def attribute_set
      mapper.attributes
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

    # Access transformer value via memonization guard
    #
    # @param [Symbol] name of value to access
    #
    # @return [Object]
    #
    # @api private
    #
    def memonized(name)
      @memonized ||= {}
      @memonized.fetch(name) do
        @memonized[name]=access(name)
      end
    end
  end
end
