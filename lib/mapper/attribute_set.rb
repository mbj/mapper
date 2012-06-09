module Mapper
  # A set of mapping attributes
  class AttributeSet
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
      reset

      self
    end

    # Return loading view on attribute set
    #
    # @return [Mapper::AttributeSet::View]
    #
    # @api private
    #
    def load_operations
      @load_operations ||= Operations.new(@set,:load)
    end

    # Return dumping view on attribute set
    #
    # @return [Mapper::AttributeSet::View]
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

  private

    # Initialize attribute set
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize()
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
