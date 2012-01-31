module Mapper
  class Mapper
    class Wrapper < Mapper
      def initialize(name,mappers)
        super(name)
        @mapper = mappers
      end

      def dump(object)
        @mapper.dump(object)
      end

      def load(object)
        @mapper.load(object)
      end
    end
  end
end
