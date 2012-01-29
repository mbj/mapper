module Mapper
  class Mapper
    class EmbeddedValue < Attribute
      def initialize(name,mapper)
        super(name,false)
        @mapper = mapper
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
