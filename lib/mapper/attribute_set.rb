class Mapper
  # A set of mapping attributes
  class AttributeSet
    include Enumerable

    # Add attribute to set
    #
    # @param [Attribute] attribute
    #
    # @return [self]
    #
    # @api private
    #
    def add(attribute)
      @set << attribute
      attribute.define_loader(loader_class)
      attribute.define_dumper(dumper_class)
      reset

      self
    end

    # Iterate over attributes in set
    #
    # @return [self]
    #   returns self when block given
    #
    # @return [Enumerator<Attribute>]
    #   return enumerato when no block given
    #
    # @api private
    #
    def each(&block)
      return to_enum(__method__) unless block_given?

      @set.each(&block)

      self
    end

    # Return operations for loading
    #
    # @return [Mapper::AttributeSet::Oparations]
    #
    # @api private
    #
    def load_operations
      @load_operations ||= Operations.new(@set,:load)
    end

    # Return operations for dumping
    #
    # @return [Mapper::AttributeSet::Operations]
    #
    # @api private
    #
    def dump_operations
      @dump_operations ||= Operations.new(@set,:dump)
    end

    # Return if attribute set is empty
    #
    # @return [true|false]
    #
    # @api  private
    #
    def empty?
      @set.empty?
    end

    # Populate class
    #
    # @param [Class] superclass
    # @param [Symbol] method
    #
    # @return [Class]
    #
    # @api private
    #
    def populate(superclass, method)
      klass = Class.new(superclass)
      each do |attribute|
        attribute.send(method,klass)
      end

      klass
    end

    # Return loader class
    #
    # @return [Class]
    #
    # @api private
    #
    def loader_class
      @loader_class ||= Class.new(Transformer::Loader)
    end

    # Return dumper class
    #
    # @api private
    #
    # @return [Class]
    #
    def dumper_class
      @dumper_class ||= Class.new(Transformer::Dumper)
    end

  private

    # Initialize attribute set
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize
      @set = Set.new
    end

    # Reset caches
    #
    # @return [self]
    #
    # @api private
    #
    def reset
      @load_operations = @dump_operations = nil
      self
    end
  end
end
