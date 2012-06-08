module Mapper
  # mapped attribute base class
  class Attribute
    extend ::Virtus::DescendantsTracker

    # Build a mapper after resolving class or name
    #
    # @param [Symbol] name
    # @param [Class|Symbol] class_or_name
    # @param [Hash] options
    #
    # @return [Attribuete]
    #
    # @api private
    #
    def self.build(name,class_or_name,options={})
      type = determine_type(class_or_name)
      type.new(name,options)
    end

    # Resolving class or name
    #
    # @param [Class|Symbol] class_or_name
    #
    # @return [Class<Attribute>]
    #
    # @api private
    #
    def self.determine_type(class_or_name)
      # This test needs to be removed by a primitive lookup like in Virtus
      # As there is currently no support for specialized primitives it is not done.
      if class_or_name == ::Object
        return Attribute::Object
      end

      type = descendants.detect do |descendant| 
        descendant.handle?(class_or_name) 
      end

      unless type
        raise ArgumentError,"Unable to determine mapping from: #{class_or_name.inspect}"
      end

      type
    end

    # Return attributes constant name
    #
    # @example
    #   Mapper::Attribute.const_name # => :Attribute
    #
    # @return [Symbol]
    #
    # @api private
    #
    def self.const_name
      name.split('::').last.to_sym
    end

    # Check if attribute handles a specific class or name
    #
    # @return [True|False]
    #
    # @api private
    def self.handle?(class_or_name)
      handles.include?(class_or_name)
    end

    # Return entities an attribute does handle
    #
    # @return [Array] 
    #
    # @api private
    #
    def self.handles
      [self,const_name]
    end
  end
end
