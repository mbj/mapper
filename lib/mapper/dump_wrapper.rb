module Mapper
  # Wraps a raw dump to abstract away hash 
  # Public readers are defined via DumpWrapper.define_reader
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
