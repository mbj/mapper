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

      def load(dump)
        @mapper.load(dump)
      end
    end
  end
end
