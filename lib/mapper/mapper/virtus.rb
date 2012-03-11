module Mapper
  class Mapper
    class Virtus < Resource
      attr_reader :model

      def initialize(model,attributes)
        super(attributes)
        @model = model
      end

      def load(dump)
        @model.new(super(::Mapper.deep_copy(dump)))
      end

      def dump(object)
        ::Mapper.deep_copy(super(object))
      end

    end
  end
end
