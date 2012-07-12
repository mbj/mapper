class Mapper
  # A simple mapper that maps to a document (Hash)
  class Document < Mapper

    # Return loader for dump
    #
    # @param [Hash] dump
    #
    # @return [Loader]
    #
    # @api private
    #
    def loader(dump)
      super(wrap_dump(dump))
    end

  private

    # Wrap hash dump
    #
    # @param [Hash] dump
    #
    # @return [DumpWrapper]
    #
    # @api private
    #
    def wrap_dump(dump)
      dump_wrapper_class.new(dump)
    end

    # Return dump wrapper class
    #
    # @param [Hash] dump
    #
    # @return [Class]
    #
    # @api private
    #
    def dump_wrapper_class
      attributes.populate(DumpWrapper, :define_dump_reader)
    end

    memoize :dump_wrapper_class
  end
end
