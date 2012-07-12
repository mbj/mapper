class Mapper
  class Veritas < Mapper
    # Builder for veritas mappers
    class Builder < ::Mapper::Builder

      # Set relation
      #
      # @param [Veritas::Relation] relation
      #
      # @return [self]
      #
      # @api private
      #
      def relation(relation)
        @relation = relation

        self
      end

      # Return Mapper
      #
      # @return [self]
      #
      # @api private
      #
      def mapper
        @mapper_class.new(@model, attributes, read_relation)
      end

      # Build relation header array
      #
      # @return [Array]
      #
      # @api private
      #
      def build_header
        attributes.each_with_object([]) do |attribute, header|
          header.concat(self.class.to_veritas_header_component(attribute))
        end
      end

      # Return veritas attribute class for attribute
      #
      # @param [Mapper::Attribute] attribute
      #
      # @return [Veritas::Attribute]
      #
      # @api private
      #
      def self.to_veritas_attribute_class(attribute)
        Object
      end
      private_class_method :to_veritas_attribute_class

      # Return veritas header components for attribute 
      #
      # @param [Mapper::Attribute] attribute
      #
      # @return [veritas::Attribute]
      #
      # @api private
      #
      def self.to_veritas_header_component(attribute)
        attribute.dump_names.map do |name|
          [name, to_veritas_attribute_class(attribute)]
        end
      end

    private 

      # Read relation
      #
      # @return [Veritas::Relation]
      #
      # @api private
      #
      def read_relation
        @relation || raise(IncompleteMapperError, 'no relation is set')
      end
    end
  end
end
