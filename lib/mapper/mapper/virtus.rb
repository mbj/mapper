module Mapper
  class Mapper
    class Virtus < Resource
      def initialize(name,mappers,model)
        super(name,mappers)
        @model = model
      end

      def load(dump)
        @model.new(super(Marshal.load(Marshal.dump(dump))))
      end
    end
  end
end
