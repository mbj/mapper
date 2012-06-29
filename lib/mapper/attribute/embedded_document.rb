class Mapper
  class Attribute
    # A mapper for embedded document pattern
    class EmbeddedDocument < Embedded

      # Load value from dump and transform via wrapped mapper
      #
      # @param [Object] value
      #
      # @return [Object]
      #
      # @api private
      #
      def load(value)
        map(super(value),:load)
      end

      # Dump from domain object and transform via wrapped mapper
      #
      # @param [Object] value
      # @return [Object]
      #
      # @api private
      #
      def dump(value)
        map(super(value),:dump)
      end

    private

      # Map values via wrapped mapper
      #
      # Inner mapper is only called whan value is not nil
      #
      # @param [Object] value
      #   the value to transform
      #
      # @param [Symbol] method
      #   the method to use for transformation
      #
      # @return [Object]
      #
      # @api private
      #
      def map(value,method)
        unless value.nil?
          @mapper.send(method,value)
        end
      end
    end
  end
end
