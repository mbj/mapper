module Mapper
  class Mapper
    class Collection < Mapper
      attr_reader :mapper

      def initialize(name,options=EMPTY_OPTIONS)
        super(name,options)
        @mapper = options.fetch(:mapper) do 
          raise ArgumentError,'missing :mapper in +options+'
        end
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
