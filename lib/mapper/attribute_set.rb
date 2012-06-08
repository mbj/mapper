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

    # Return if attribute set is empty
    #
    # @return [true|false]
    #
    # @api  private
    #
    def empty?
      @set.empty?
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

    # Return all dump names of attributes that are keys
    #
    # @return [Array<Symbol>]
    #
    # @api private
    #
    def dump_key_names
      @dump_key_names ||= key_attributes.map(&:dump_names).flatten
    end

    # Return all names of domain object attributes in set
    #
    # @return [Array<Symbol>]
    #
    # @api private
    #
    def load_names
      load_map.keys
    end
    
    # Return attribute selected by dump name
    #
    # @param [Symbol] name
    #
    # @return [Attribute]
    #
    # @raise [IndexError]
    #   when not found
    #
    # @api private
    #
    def fetch_dump_name(name)
      dump_map.fetch(name) 
    end

    # Return attribute selected by load name
    #
    # @param [Symbol] name
    #
    # @return [Attribute]
    #
    # @raise [IndexError]
    #   when not found
    #
    # @api private
    #
    def fetch_load_name(name)
      load_map.fetch(name)
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

    # Return all attributes that hold part of key
    #
    # @return [Enumerable]
    #
    # @api private
    #
    def key_attributes
      @set.select(&:key?)
    end


    # Return map of load names to attribute
    #
    # @return [Hash<Symbol,Attribute>]
    #
    # @api private
    #
    def load_map
      @load_map ||= map(:load_names)
    end

    # Return map of dump names to attribute
    #
    # @return [Hash<Symbol,Attribute>]
    #
    # @api private
    #
    def dump_map
      @dump_map ||= map(:dump_names)
    end

    # Create a map from attributes
    #
    # Map building decomposition part to keep flog happy...
    #
    # @param [Symbol] method
    #   the method to invoke on attribute
    #
    # @return [Hash<Symbol,Attribute]
    #
    # @api private
    def map(method)
      Hash[map_entries(method)]
    end

    # Return arrays names to be mapped
    #
    # Map building decomposition part to keep flog happy...
    #
    # @param [Symbol] method
    #   the method to invoke on attribute
    #
    # @return [Enumerable]
    #
    # @api private
    #
    def map_names(method)
      @set.map do |attribute|
        [attribute,attribute.send(method)]
      end
    end

    # Return entries to map
    #
    # Map building decomposition part to keep flog happy...
    #
    # @param [Symbol] method
    #   the method to invoke on attribute
    #
    # @return [Enumerable]
    #
    # @api private
    #
    def map_entries(method)
      entries = []

      map_names(method).each do |attribute,names|
        entries.concat(names.product([attribute]))
      end

      entries
    end

    # Reset caches
    #
    # @return [self]
    #
    # @api private
    #
    def reset
      @dump_map = @load_map = @dump_key_names = nil
      self
    end
  end
end
