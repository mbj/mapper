module Mapper
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
        @dump ||= map(@operations.names)
      end

      # Return key
      #
      # @return [Object]
      #
      # @api private
      #
      def key
        @key ||= map(@operations.keys)
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
        super(object,mapper.attributes.dump_operations)
      end
    end
  end
end
