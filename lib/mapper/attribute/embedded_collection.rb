module Mapper
  # A mapped attribute
  class Attribute
    # An attribute mapped to embedded collection
    class EmbeddedCollection < Embedded

      # Load attribute from dump
      #
      # This method uses wrapped mapper to transform items.
      #
      # @param [Array] value
      #
      # @return [Array]
      #
      # @api private
      #
      def load(value)
        collect(super(value),:load)
      end

      # Dump attribute from domain object
      #
      # This method uses wrapped mapper to transform items.
      #
      # @param [Array] value
      #
      # @return [Array]
      #
      # @api private
      def dump(value)
        collect(super(value),:dump)
      end

      private

      # Collect values after transforming via wrapped mapper
      #
      # @param [Array] value
      # @param [Symbol] method
      #
      # @return [Array]
      #
      # @api private
      #
      def collect(value,method)
        value.map do |item|
          @mapper.send(method,item)
        end
      end
    end
  end
end
