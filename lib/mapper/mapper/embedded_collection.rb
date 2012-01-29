module Mapper
  class Mapper
    class EmbeddedCollection < Mapper
      def initialize(name,mapper)
        super(name)
        @mapper = mapper
      end
   
      def dump(object)
        object.map do |item|
          @mapper.dump(item)
        end
      end
   
      def load(object)
        object.map do |item|
          @mapper.load(item)
        end
      end
    end
  end
end
