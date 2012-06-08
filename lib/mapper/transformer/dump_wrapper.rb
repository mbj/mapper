module Mapper
  class Transformer
    # Wraps a raw dump to abstract away hash 
    # Not naturally a subclass of transformer, hence the undefs.
    # But I'd like to use the Transformer.define_reader.
    #
    class DumpWrapper < Transformer

      undef :transformation 
      undef :read
      undef :read_nocache

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
