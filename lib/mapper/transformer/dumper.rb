module Mapper
  class Transformer
    # Dumper base class
    class Dumper < Transformer
      # Return domain object to dump
      #
      # @return [Object]
      #
      # @api private
      #
      attr_reader :object

      # Return dumped representation of domain object
      #
      # @return [Hash]
      #
      # @api private
      #
      def dump
        map(attribute_set.dump_names)
      end

    private

      # Initialize dumper
      #
      # @param [Object] object
      #   the domain object to dump
      #
      # @api private
      #
      # @return [undefined]
      #
      def initialize(object)
        @object = object
      end

      # Access dumped representation of domain object attribute with name
      #
      # This method takes aliasing into account.
      #
      # @param [Symbol] name
      #   the name of the attribute
      #
      # @return [Object]
      #   the transformed object
      #
      # @api private
      #
      def access(name)
        attribute(name).dump(@object)
      end

      # Resolve attribute via dump name
      #
      # @param [Symbol] name
      #
      # @return [Attribute]
      #
      # @api private
      #
      def attribute(name)
        attribute_set.fetch_dump_name(name)
      end
    end
  end
end
