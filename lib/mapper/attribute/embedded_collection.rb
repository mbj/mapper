class Mapper
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
        map(super(value), :load)
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
        map(super(value), :dump)
      end

    private

      # Map values via wrapped mapper
      #
      # @param [Array] value
      # @param [Symbol] method
      #
      # @return [Array]
      #
      # @api private
      #
      def map(value, method)
        value.map do |item|
          @mapper.send(method, item)
        end
      end
    end
  end
end
