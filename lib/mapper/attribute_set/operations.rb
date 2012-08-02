class Mapper
  # A set of mapping attributes
  class AttributeSet
    # An attribute set scoped to specific operation (dump or load)
    class Operations
      include Immutable

      # Return names of attributes
      #
      # @return [Array]
      #
      # @api private
      #
      def names
        map.keys.to_set
      end

      # Return names of keys
      #
      # @return [Array]
      #
      # @api private
      #
      def keys
        names.select { |name| key?(name) }.to_set
      end

      # Execute operation on value
      #
      # @param [Symbol] name
      # @param [Object] value
      #
      # @return [Object]
      #
      # @api private
      #
      def execute(name, value)
        attribute(name).send(@operation, value)
      end

    private

      # Initialize attribute set view
      #
      # @param [Set] set
      #
      # @param [Symbol] operation
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(set, operation)
        @set, @operation = set, operation
      end

      # Return map of name to attributes
      #
      # @return [Hash<Symbol, Attribute>]
      #
      # @api private
      def map
        Hash[map_entries]
      end

      # Return attribute from set
      #
      # @param [Symbol] name
      #
      # @return [Attribute]
      #
      # @api private
      #
      def attribute(name)
        map.fetch(name)
      end

      # Return entries of map
      #
      # Used to build #map, present to keep metrics low.
      #
      # @return [Array]
      #
      # @api private
      #
      def map_entries
        entries = []
        attributes_with_names.each do |attribute, names|
          entries.concat(names.product([attribute]))
        end

        entries
      end

      # Return attribute with operation scoped names
      #
      # Used to build #map, present to keep metrics low.
      #
      # @return [Array]
      #
      # @api private
      #
      def attributes_with_names
        entries = []
        @set.each do |attribute|
          entries << [attribute, attribute_names(attribute)]
        end

        entries
      end

      # Return operation names of attribute
      #
      # Used to build #map, present to keep metrics low.
      #
      # @return [Array]
      #
      # @api private
      def attribute_names(attribute)
        attribute.send("#{@operation}_names")
      end

      # Check if attribute with name is a key
      #
      # Used to build #keys, presnet to keep metrics low.
      #
      # @return [true|false]
      #
      # @api private
      def key?(name)
        attribute(name).key?
      end

      memoize :keys, :names, :map
    end
  end
end
