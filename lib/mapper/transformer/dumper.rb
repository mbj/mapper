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
        @dump ||= map(attribute_set.dump_names)
      end

      # Return key
      #
      # @return [Object]
      #
      # @api private
      #
      def key
        @key ||= map(attribute_set.dump_key_names)
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
        super(object,:dump)
      end
    end
  end
end
