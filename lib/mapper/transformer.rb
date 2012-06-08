module Mapper
  # Base class for loader and dumper classes
  class Transformer
    # Return source of transformation
    #
    # @return [Object]
    #
    # @api private
    #
    attr_reader :source

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
      # comment to keep vim ruby syntax happy
      <<-RUBY
        def #{name}
          read(:#{name})
        end
      RUBY
    end

    # Define reader on class
    #
    # @param [Symbol] name
    #   the name of the reader to define
    #
    # @return [self]
    #
    # @api private
    #
    def self.define_reader(name)
      source = reader_method_source(name)
      class_eval(source,__FILE__,__LINE__)

      self
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
    def initialize(source,operation)
      @source,@operation = source,operation
    end

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
      transformation(name).send(@operation,@source)
    end

    # Return transformation
    #
    # (Currently an Attribute)
    #
    # @return [Transformation]
    #
    # @api private
    #
    # TODO: Will be replaced by real transformation
    #
    def transformation(name)
      attribute_set.send("fetch_#{@operation}_name",name)
    end
  end
end
