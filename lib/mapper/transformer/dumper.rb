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
      def dumped
        collect(mapper.dump_names)
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

      # Access dumped value
      #
      # @param [Symbol] name of field to access
      #
      # @return [Object]
      #
      # @api private
      #
      def dump(name)
        memonize(name) do
          attribute(name).dump(@object)
        end
      end
    end
  end
end
