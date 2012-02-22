module Mapper
  class Mapper
    class Virtus < Resource
      def initialize(name,mappers,model)
        super(name,mappers)
        @model = model
      end

      def load(dump)
        @model.new(super(deep_copy(dump)))
      end

      def dump(object)
        deep_copy(super(object))
      end

    private

      def deep_copy(value)
        Marshal.load(Marshal.dump(value))
      end
    end
  end
end
