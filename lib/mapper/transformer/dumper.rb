class Mapper
  class Transformer
    # Dumper base class
    class Dumper < Transformer
      # Return dumped representation of domain object
      #
      # @return [Hash]
      #
      # @api private
      #
      def dump
        @dump ||= map(operations.names)
      end

    private

      # Return dumper operations
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
