class Mapper
  # mapped attribute base class
  class Attribute
    extend DescendantsTracker

    # Build a mapper after resolving class or name
    #
    # @param [Symbol] name
    # @param [Hash] options
    #
    # @return [Attribuete]
    #
    # @api private
    #
    def self.build(name, options={})
      type = determine_type(options.fetch(:type, :object))
      type.new(name, options)
    end

    # Resolving class or name
    #
    # @param [Symbol] symbol
    #
    # @return [Class<Attribute>]
    #
    # @api private
    #
    def self.determine_type(symbol)
      table.fetch(symbol) do
        raise ArgumentError, "Unable to determine mapping from #{symbol.inspect}"
      end
    end

    # Return table
    #
    # TODO: This has be replaced with inflector use
    #
    # @return [Hash<Symbol, Class>]
    #
    # @api private
    #
    #
    def self.table
      table = {
        Attribute::Object => :object,
        Attribute::Custom => :custom,
        Attribute::EmbeddedDocument => :embedded_document,
        Attribute::EmbeddedCollection => :embedded_collection
      }

      table.invert
    end

    private_class_method :table
  end
end
