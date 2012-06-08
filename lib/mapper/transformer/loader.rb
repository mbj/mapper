module Mapper
  class Transformer
    # Loader base class
    class Loader < Transformer
      # Return input dump
      #
      # @return [Object]
      #
      # @api private
      #
      attr_reader :dump

      # Return loaded domain object
      #
      # @return [Object]
      #
      # @api private
      #
      def object
        mapper.instanciate_model(attributes)
      end

      # Return loaded attributes
      #
      # @return [Hash]
      #
      # @api private
      #
      def attributes
        map(attribute_set.load_names)
      end

    private

      # Initialize loader with dumped representation
      #
      # @param [Object] dump
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(dump)
        @dump = dump
      end

      # Access domain object attribute with name
      #
      # @param [Symbol] name
      #
      # @return [Object]
      #
      # @api private
      #
      def access(name)
        attribute(name).load(@dump)
      end

      # Resolve attribute via load name
      #
      # @param [Symbol] name
      #
      # @return [Attribute]
      #
      # @api private
      def attribute(name)
        attribute_set.fetch_load_name(name)
      end
    end
  end
end
