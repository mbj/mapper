class Mapper
  class Transformer
    # Loader base class
    class Loader < Transformer
      # Return loaded domain object
      #
      # @return [Object]
      #
      # @api private
      #
      def object
        @object ||= instantiate(attributes)
      end

      # Return loaded attributes
      #
      # @return [Hash]
      #
      # @api private
      #
      def attributes
        @attributes ||= map(operations.names)
      end

    private

      # Instantiate model from attributes
      #
      # @param [Object] attributes
      #
      # @return [Object]
      #
      # @api private
      def instantiate(attributes)
        model.new(attributes)
      end

      # Return model to load
      #
      # @return [Object]
      #
      # @api private
      #
      def model
        @mapper.model
      end

      # Return load operations
      #
      # @return [AttributeSet::Operations]
      #
      # @api private
      #
      def operations
        mapper_attributes.load_operations
      end
    end
  end
end
