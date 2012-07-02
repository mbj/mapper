class Mapper
  class Veritas < Mapper
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

      # Mapper
      #
      # @return [self]
      #
      # @api private
      #
      def mapper
        @mapper_class.new(@model,attributes,read_relation)
      end

    private

      # Read relation
      #
      # @return [Veritas::Relation]
      #
      # @api private
      #
      def read_relation
        @relation || raise(RuntimeError,'need a relation to instancitate vertias mapper') 
      end
    end
  end
end
