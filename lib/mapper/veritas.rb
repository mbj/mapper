require 'veritas'

class Mapper
  # A mapper for veritas relations
  class Veritas < Mapper
    # Initialize loader from dump
    #
    # @param [Veritas::Tuple] tuple
    #
    # @return [Transformer::Loader]
    #
    # @api private
    #
    def loader(tuple)
      super(wrap_tuple(tuple))
    end

    # Return reader
    #
    # @return [Reader]
    #
    # @api private
    #
    def reader
      Reader.new(self,@relation)
    end

    # Return relation header
    #
    # @return [Veritas::Relation::Header]
    #
    # @api private
    #
    def header
      @relation.header
    end

    # Return builder class
    #
    # @return [Mapper::Veritas::Builder]
    #
    # @api private
    #
    def self.builder_class
      ::Mapper::Veritas::Builder
    end
    private_class_method :builder_class

  private

    # Return dump wrapped 
    #
    # @param [Veritas::Tuple] tuple
    #
    # @api private
    #
    # @return [Mapper::Veritas::DumpWrapper]
    #
    def wrap_tuple(tuple)
      dump_wrapper_class.new(tuple)
    end

    # Return dump wrapper class
    #
    # @return [Class]
    #
    # @api private
    #
    def dump_wrapper_class
      attributes.populate(DumpWrapper,:define_dump_reader)
    end

    # Initialize veritas mapper
    #
    # @param [Object] model
    # @param [AttributeSet] attributes
    # @param [Veritas::Relation] relation
    #
    # @api private
    #
    def initialize(model,attributes,relation)
      super(model,attributes)
      @relation = relation
    end

    memoize :dump_wrapper_class
  end
end

require 'mapper/veritas/dump_wrapper'
require 'mapper/veritas/reader'
require 'mapper/veritas/builder'
