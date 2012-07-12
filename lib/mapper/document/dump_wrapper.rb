class Mapper
  class Document
    # Wraps a raw dump to abstract away hash
    class DumpWrapper
      extend ReaderDefiner

    private

      # Initialize dump wrapper
      #
      # @param [Hash] dump
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(dump)
        @dump = dump
      end

      # Read a dump value
      #
      # @param [Symbol] name
      #
      # @return [Object]
      #
      # @api private
      #
      def read(name)
        @dump.fetch(name)
      end
    end
  end
end
