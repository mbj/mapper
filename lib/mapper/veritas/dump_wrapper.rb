class Mapper
  class Veritas < Mapper
    # A dump wrapper for veritas tuples
    class DumpWrapper
      extend Mapper::ReaderDefiner

      # Initialize dump wrapper
      #
      # @param [Veritas::Tuple] tuple
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(tuple)
        @tuple = tuple
      end

    private

      # Read attribute with name
      #
      # @param [Symbol] name
      #
      # @return [Object]
      #
      # @api private
      #
      def read(name)
        @tuple.call(name)
      end
    end
  end
end

