module Mapper
  # A set of mapping attributes
  class AttributeSet
    # Return wheather this attribute set is empty
    #
    # @return [True|False]
    #
    # @api private
    #
    def empty?
      @set.empty?
    end

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

    # Return all dump names of attributes in set
    #
    # @return [Array<Symbol>]
    #
    # @api private
    #
    def dump_names
      dump_map.keys
    end

    # Return all names of domain object attributes in set
    #
    # @return [Array<Symbol>]
    #
    # @api private
    #
    def load_names
      @load_names ||=
        @set.each_with_object([]) do |attribute,names|
          names.concat(attribute.load_names)
        end
    end
    
    # Return attribute selected by dump name
    #
    # @param [Symbol] name
    #
    # @return [Attribute]
    #
    # @raise [ArgumentError]
    #   when not found
    #
    # @api private
    #
    def fetch_dump_name(name)
      dump_map.fetch(name) do
        raise ArgumentError,"no attribute with dump name of #{name.inspect} does exist"
      end
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

    # Return map of dump names to attribute
    #
    # @return [Hash<Symbol,Attribute>]
    #
    # @api private
    #
    def dump_map
      @dump_map ||= 
        Hash[
          @set.each_with_object([]) do |attribute,entries|
            entries.concat(attribute.dump_names.product([attribute]))
          end
        ]
    end

    # Reset caches
    #
    # @return [self]
    #
    # @api private
    #
    def reset
      @dump_map = @load_names = nil
      self
    end
  end
end
